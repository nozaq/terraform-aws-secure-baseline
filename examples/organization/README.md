# organization example

This example shows how you can configure multiple AWS accounts, one master account and several member accounts, in AWS Organization with secure-baseline module.

`secure-baseline` module can be set to configure the individual AWS account as well as accounts in AWS Organization. This behavior is controlled by `account_type` input variable, the default value is `individual` meaning that the AWS account assumed to have no relation with other AWS accounts.
When it sets to `master`, this module configure the account to be ready to gather various audit logs from other member accounts as well as from the master account itself. Member accounts should set `account_type` to `member` , then their audit logs are sent to the master account so that all information are centrally managed there.

## Master Account

In the master account configuration, you need to set `account_type` to `master` and specify member account information in `member accounts`.

The following shows a sample usage.

```hcl
module "secure_baseline" {
  source = "nozaq/secure_baseline"

  account_type                         = "master"
  member_accounts                      = [
    {
      account_id = "id_of_the_member_account"
      email      = "email_of_the_member_account@example.com"
    }
  ]

  audit_log_bucket_name                = "audit-log-bucket-1234"

  ...
}
```

The S3 bucket named `audit-log-bucket-1234` is created in this master account, and used to store audit log records from both the master account and member accounts.

## Member Account

In a member account configuration, you need to set `account_type` to `member` and specify master account ID in `master_account_id`.

```hcl
data "aws_organizations_organization" "org" {}

module "secure_baseline" {
  source = "nozaq/secure_baseline"

  account_type                   = "member"
  master_account_id              = data.aws_organizations_organization.org.master_account_id
  use_external_audit_log_bucket  = true
  audit_log_bucket_name          = "audit-log-bucket-1234"

  ...
}
```

Since `use_external_audit_log_bucket` set to `true`, no S3 bucket is created in member accounts. Instead, the bucket in the master account is used to store audit log records. You can create an individual S3 bucket in each member account by setting it to `false`.
