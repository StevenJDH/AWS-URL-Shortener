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

module "s3-static-hosting-bucket" {
  source = "github.com/StevenJDH/Terraform-Modules//aws/s3?ref=main"

  bucket_name             = var.domain
  enable_versioning       = false
  block_public_policy     = var.is_subdomain
  restrict_public_buckets = var.is_subdomain

  additional_resource_policy_statements = var.is_subdomain ? [] : local.public_policy_statement

  lifecycle_rules = var.is_subdomain ? [] : [
    {
      rule_name            = "expired-cleanup"
      enable_rule          = true
      expiration_days      = 14
      filter_size_lt_bytes = 1
      filter_tags          = {
        expire = "true"
      }
    },
  ]

  tags = var.tags
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = module.s3-static-hosting-bucket.id

  dynamic "index_document" {
    for_each = var.is_subdomain == false ? [true] : []
    content {
      suffix = "index.html"
    }
  }

  dynamic "error_document" {
    for_each = var.is_subdomain == false ? [true] : []
    content {
      key = "error.html"
    }
  }

  dynamic "redirect_all_requests_to" {
    for_each = var.is_subdomain ? [true] : []
    content {
      host_name = var.domain
      protocol  = "http"
    }
  }
}

resource "aws_route53_record" "this" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.domain
  type    = "A"

  alias {
    name                   = aws_s3_bucket_website_configuration.this.website_domain
    zone_id                = module.s3-static-hosting-bucket.hosted_zone_id
    evaluate_target_health = false
  }
}