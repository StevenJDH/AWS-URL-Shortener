# AWS URL Shortener Module

## Usage

```hcl
module "s3-root-domain-bucket" {
  source = "./modules/aws-url-shortener"

  domain          = "my.link"
  expiration_days = 14

  tags = {
    # Similar to provider tag propagation, but module scoped.
    type = "example"
  }
}

module "s3-www-subdomain-bucket" {
  source = "./modules/aws-url-shortener"

  domain         = "www.my.link"
  is_subdomain   = true

  tags = {
    # Similar to provider tag propagation, but module scoped.
    type = "example"
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_s3-static-hosting-bucket"></a> [s3-static-hosting-bucket](#module\_s3-static-hosting-bucket) | github.com/StevenJDH/Terraform-Modules//aws/s3 | main |

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_s3_bucket_website_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_route53_zone.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | Domain to use for shortlinks. Must only be the apex part such as `my.link`. | `string` | n/a | yes |
| <a name="input_expiration_days"></a> [expiration\_days](#input\_expiration\_days) | Number of days to keep a temporary shortlink. The value must be a non-zero positive integer. Only used if is\_subdomain is set to false. | `number` | `14` | no |
| <a name="input_is_subdomain"></a> [is\_subdomain](#input\_is\_subdomain) | Indicates whether or not to configure this bucket for subdomain redirection. This is not needed if only the root level domain (apex) will be used. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags. | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_hosted_zone_id"></a> [hosted\_zone\_id](#output\_hosted\_zone\_id) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_website_domain"></a> [website\_domain](#output\_website\_domain) | n/a |
| <a name="output_website_endpoint"></a> [website\_endpoint](#output\_website\_endpoint) | n/a |
<!-- END_TF_DOCS -->