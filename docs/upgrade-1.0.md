# Version 1.0 Upgrade Guide

This document outlines a way to upgrade this module from v0.x to v1.0 or later.
The following guidance only applies if `var.use_external_audit_log_bucket` is set to `false`, which is a default behavior.

Following the changes introduced in AWS provider v4.0, several configurations for S3 buckets were extracted from `aws_s3_bucket` resource to newly added resources.
It is recommended to import these resources before running `terraform apply` to prevent data loss.

See [the upgrade guide for AWS provider] for more detail.

## Audit log bucket migrations

Following configurations from `module.audit_log_bucket[0].aws_s3_bucket.content` were extracted to separated resources.

- `module.audit_log_bucket[0].aws_s3_bucket_acl.content`
- `module.audit_log_bucket[0].aws_s3_bucket_lifecycle_configuration.content`
- `module.audit_log_bucket[0].aws_s3_bucket_logging.content`
- `module.audit_log_bucket[0].aws_s3_bucket_server_side_encryption_configuration.content`
- `module.audit_log_bucket[0].aws_s3_bucket_versioning.content`

To import the current configuration into these resources, use `terraform import` command as follows.

```sh
$ terraform import "$MODULE_PATH.module.audit_log_bucket[0].aws_s3_bucket_acl.content" "$AUDIT_LOG_BUCKET"

$ terraform import "$MODULE_PATH.module.audit_log_bucket[0].aws_s3_bucket_lifecycle_configuration.content" "$AUDIT_LOG_BUCKET"

$ terraform import "$MODULE_PATH.module.audit_log_bucket[0].aws_s3_bucket_logging.content" "$AUDIT_LOG_BUCKET"

$ terraform import "$MODULE_PATH.module.audit_log_bucket[0].aws_s3_bucket_server_side_encryption_configuration.content" "$AUDIT_LOG_BUCKET"

$ terraform import "$MODULE_PATH.module.audit_log_bucket[0].aws_s3_bucket_versioning.content" "$AUDIT_LOG_BUCKET"
```

### Notes

- `$MODULE_PATH` should be replaced the actual path of this module in your project, e.g. `module.secure_baseline`.
- `$AUDIT_LOG_BUCKET` should be replaced with the state bucket name. The actual value in your state file as `module.audit_log_bucket.aws_s3_bucket[0].content.id`.

## Access logging bucket migrations

Following configurations from `module.audit_log_bucket[0].aws_s3_bucket.access_log` were extracted to separated resources.

- `module.audit_log_bucket[0].aws_s3_bucket.access_log`
- `module.audit_log_bucket[0].aws_s3_bucket_acl.access_log`
- `module.audit_log_bucket[0].aws_s3_bucket_lifecycle_configuration.access_log`
- `module.audit_log_bucket[0].aws_s3_bucket_server_side_encryption_configuration.access_log`

These resources can be imported by `terraform import` command as well.

```sh
$ terraform import "$MODULE_PATH.module.audit_log_bucket[0].aws_s3_bucket.access_log" "$ACCESS_LOG_BUCKET"
$ terraform import "$MODULE_PATH.module.audit_log_bucket[0].aws_s3_bucket_acl.access_log" "$ACCESS_LOG_BUCKET"

$ terraform import "$MODULE_PATH.module.audit_log_bucket[0].aws_s3_bucket_lifecycle_configuration.access_log" "$ACCESS_LOG_BUCKET"

$ terraform import "$MODULE_PATH.module.audit_log_bucket[0].aws_s3_bucket_server_side_encryption_configuration.access_log" "$ACCESS_LOG_BUCKET"

```

### Notes

- `$MODULE_PATH` should be replaced the actual path of this module in your project, e.g. `module.secure_baseline`.
- `$ACCESS_LOG_BUCKET` should be replaced with the state bucket name. The actual value in your state file as `module.audit_log_bucket[0].aws_s3_bucket.access_log.id`.

[aws provider]: https://github.com/hashicorp/terraform-provider-aws
[the upgrade guide for aws provider]: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/guides/version-4-upgrade
