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

module "s3-root-domain-bucket" {
  source = "./modules/aws-url-shortener"

  domain          = var.domain
  expiration_days = 14

  tags = local.tags
}

module "s3-www-subdomain-bucket" {
  source = "./modules/aws-url-shortener"

  domain         = "www.${var.domain}"
  is_subdomain   = true

  tags = local.tags
}

resource "aws_s3_object" "index-html" {
  bucket                 = module.s3-root-domain-bucket.id
  key                    = "index.html"
  source                 = "./public_html/index.html"
  content_type           = "text/html"
  server_side_encryption = "AES256"
  etag                   = filemd5("./public_html/index.html")
}

resource "aws_s3_object" "error-html" {
  bucket                 = module.s3-root-domain-bucket.id
  key                    = "error.html"
  source                 = "./public_html/error.html"
  content_type           = "text/html"
  server_side_encryption = "AES256"
  etag                   = filemd5("./public_html/error.html")
}

resource "aws_s3_object" "test" {
  bucket                 = module.s3-root-domain-bucket.id
  key                    = "test"
  content_type           = "binary/octet-stream"
  server_side_encryption = "AES256"
  website_redirect       = "https://www.google.com"
}