:: This file is part of AWS URL Shortener <https://github.com/StevenJDH/AWS-URL-Shortener>.
:: Copyright (C) 2023 Steven Jenkins De Haro.
::
:: AWS URL Shortener is free software: you can redistribute it and/or modify
:: it under the terms of the GNU General Public License as published by
:: the Free Software Foundation, either version 3 of the License, or
:: (at your option) any later version.
::
:: AWS URL Shortener is distributed in the hope that it will be useful,
:: but WITHOUT ANY WARRANTY; without even the implied warranty of
:: MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
:: GNU General Public License for more details.
::
:: You should have received a copy of the GNU General Public License
:: along with AWS URL Shortener.  If not, see <http://www.gnu.org/licenses/>.

@echo off
SETLOCAL
VERIFY OTHER 2>NUL

title AWS URL Shortener
echo.

if not defined AWS_URL_SHORTENER (
    echo Not configured. Please use 'setx AWS_URL_SHORTENER my.link' first, and try again. 1>&2
    exit /B %ERRORLEVEL%
) else if not exist %USERPROFILE%\.aws\credentials (
    echo AWS CLI not installed or configured. 1>&2
    exit /B %ERRORLEVEL%
)

set __S3_BUCKET=%AWS_URL_SHORTENER%
set __VERSION=1.0.0
set __BAT_NAME=%~n0

set operation=%1
set shortlink=%2
set destination=%3
set expires=%4

if /i "%operation%"=="create" (
    GOTO create
) else if /i "%operation%"=="remove" (
    GOTO remove
) else if /i "%operation%"=="list" (
    GOTO list
) else if /i "%operation%"=="describe" (
    GOTO describe
) else if /i "%operation%"=="version" (
    GOTO version
) else (
    GOTO usage
)

:create
if not defined shortlink GOTO usage
if not defined destination GOTO usage
:: Adding Delayed Expansion here because it conflicts with JMESPath used in list operation.
SETLOCAL EnableDelayedExpansion
type nul > "%temp%\%shortlink%" && ^
aws s3 cp "%temp%\%shortlink%" s3://%__S3_BUCKET%/ --website-redirect %destination% && ^
call :func_decide_tagging_for %shortlink% %expires% && ^
call :func_display_details_for %shortlink% && ^
del "%temp%\%shortlink%" && ^
call :func_completed || (set /A err=!ERRORLEVEL! && del "%temp%\%shortlink%" 2>nul && call :func_throw)
exit /B %err%

:func_decide_tagging_for
if /i "%~2"=="expires" (
    echo Tagging shortlink for expiration...
    aws s3api put-object-tagging --bucket "%__S3_BUCKET%" --key "%~1" --tagging "TagSet=[{Key=expire,Value=true}]"
)
exit /B

:remove
if not defined shortlink GOTO usage
aws s3 rm s3://%__S3_BUCKET%/%shortlink% && call :func_completed || call :func_throw
exit /B %ERRORLEVEL%

:list
aws s3api list-objects-v2 ^
    --bucket "%__S3_BUCKET%" ^
    --query "Contents[? Size==`0` && !(ends_with(Key, `/`))].{Shortlinks: Key,UTCLastModified: LastModified}" ^
    --output table && call :func_completed || call :func_throw
exit /B %ERRORLEVEL%

:describe
if not defined shortlink GOTO usage
call :func_display_details_for %shortlink% && call :func_completed || call :func_throw
exit /B %ERRORLEVEL%

:func_display_details_for
:: Using JMESPath to make output consistent when there is an expiration or not set.
aws s3api head-object ^
    --bucket "%__S3_BUCKET%" ^
    --key "%~1" ^
    --query "[{Property: 'Shortlink', Value: join('', ['%__S3_BUCKET%/','%~1'])}, {Property: 'Destination', Value: WebsiteRedirectLocation}, {Property: 'Expiration', Value: Expiration || 'Never'}, {Property: 'UTCLastModified ', Value: LastModified}]" ^
    --output table
exit /B

:version
echo AWS URL Shortener v%__VERSION%
exit /B 0

:usage
echo Usage: %__BAT_NAME% OPERATION shortlink_id destination_url [expires]
echo.
echo Operation:
echo   create     Creates or updates a shortlink using both required parameters.
echo   remove     Removes an existing shortlink using first parameter only.
echo   list       Lists the existing shortlinks.
echo   describe   Describes a shortlink's configuration.
echo   version    Displays the version of the script.
echo.
echo Examples:
echo   %__BAT_NAME% create foobar https://www.google.com
echo   %__BAT_NAME% create foobar https://www.google.com expires
echo   %__BAT_NAME% describe foobar
echo   %__BAT_NAME% remove foobar
exit /B 1

:func_completed
echo Operation completed successfully.
exit /B

:func_throw
echo Operation encountered errors. 1>&2
exit /B