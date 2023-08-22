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

output "s3_root_domain_bucket_id" {
  value = module.s3-root-domain-bucket.id
}

output "s3_root_domain_bucket_arn" {
  value = module.s3-root-domain-bucket.arn
}

output "s3_www_subdomain_bucket_id" {
  value = module.s3-www-subdomain-bucket.id
}

output "s3_www_subdomain_bucket_arn" {
  value = module.s3-www-subdomain-bucket.arn
}