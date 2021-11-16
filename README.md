# Rockset audit-trail terraform module

This [terraform](https://terraform.io) module configures an AWS S3 bucket to be used with Rockset's audit trail export,
and will import the audit trail into a Rockset collection for ease of use.

By default, it configures the bucket with encryption, versioning and object locking,
however all those settings are configurable. 

The simplest for of usage is

```terraform
module "audit-trail" {
  source       = "rockset/audit/aws"
}
```

Which generates a unique bucket name that starts with `rockset-audit-trail-<date based stamp>`,
but if you want a specific name, you can supply it using `bucket_name`

```terraform
module "audit-trail" {
  source       = "rockset/audit/aws"
  bucket_name  = "name-of-your-bucket"
}
```

## Requirements

The module requires a Rockset API key which can be supplied using the environment variable `ROCKSET_APIKEY`
or in the provider definition in your terraform config, and it also requires AWS credentials which
can be provided as described in the
[AWS authentication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication)
documentation for the AWS terraform provider.

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0.0 |
| <a name="requirement_rockset"></a> [rockset](#requirement\_rockset) | ~> 0.4.0 |

## Inputs

If `bucket_name` isn't specified, the module will use the default `bucket_prefix` to generate a bucket name that will be used.

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket_name | Name of the S3 bucket which will hold the Rockset audit trail | string | | no |
| bucket_prefix | Name of the S3 bucket prefix which will hold the Rockset audit trail | string | rockset-audit-trail- | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_name | Name of the S3 bucket |
| integration_name | Name of the Rockset integration that was created | 

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/rockset/terraform-audit-aws/issues) to report any bugs or file feature requests.

### Developing

If you are interested in being a contributor and want to get involved in developing this project or [help out](https://cpco.io/help-out) with our other projects, we would love to hear from you! Shoot us an [email](mailto:support@rockset.com).

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.

1. **Fork** the repo on GitHub
2. **Clone** the project to your own machine
3. **Commit** changes to your own branch
4. **Push** your work back up to your fork
5. Submit a **Pull Request** so that we can review your changes

**NOTE:** Be sure to merge the latest changes from "upstream" before making a pull request!
