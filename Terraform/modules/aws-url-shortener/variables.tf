/*
 * This file is part of AWS URL Shortener <https://github.com/StevenJDH/AWS-URL-Shortener>.
 * Copyright (C) 2023 Steven Jenkins De Haro.
 *
 * AWS URL Shortener is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * AWS URL Shortener is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with AWS URL Shortener.  If not, see <http://www.gnu.org/licenses/>.
 */

variable "domain" {
  description = "Domain to use for shortlinks. Must only be the apex part such as `my.link`."
  type        = string
}

variable "expiration_days" {
  description = "Number of days to keep a temporary shortlink. The value must be a non-zero positive integer. Only used if is_subdomain is set to false."
  type        = number
  default     = 14
}

variable "is_subdomain" {
  description = "Indicates whether or not to configure this bucket for subdomain redirection. This is not needed if only the root level domain (apex) will be used."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = null
}