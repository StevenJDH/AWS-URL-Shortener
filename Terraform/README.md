# AWS URL Shortener Backend

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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_s3-root-domain-bucket"></a> [s3-root-domain-bucket](#module\_s3-root-domain-bucket) | ./modules/aws-url-shortener | n/a |
| <a name="module_s3-www-subdomain-bucket"></a> [s3-www-subdomain-bucket](#module\_s3-www-subdomain-bucket) | ./modules/aws-url-shortener | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_s3_object.error-html](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_s3_object.index-html](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_s3_object.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | Domain to use for shortlinks. Must only be the apex part such as `my.link`. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region. | `string` | `"eu-west-3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_s3_root_domain_bucket_arn"></a> [s3\_root\_domain\_bucket\_arn](#output\_s3\_root\_domain\_bucket\_arn) | n/a |
| <a name="output_s3_root_domain_bucket_id"></a> [s3\_root\_domain\_bucket\_id](#output\_s3\_root\_domain\_bucket\_id) | n/a |
| <a name="output_s3_www_subdomain_bucket_arn"></a> [s3\_www\_subdomain\_bucket\_arn](#output\_s3\_www\_subdomain\_bucket\_arn) | n/a |
| <a name="output_s3_www_subdomain_bucket_id"></a> [s3\_www\_subdomain\_bucket\_id](#output\_s3\_www\_subdomain\_bucket\_id) | n/a |
<!-- END_TF_DOCS -->