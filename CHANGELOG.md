<a name="unreleased"></a>
## [Unreleased]


<a name="0.23.0"></a>
## [0.23.0] - 2020-11-23
### Feat
- use the audit log bucket for Flow Logs by default ([#152](https://github.com/nozaq/terraform-aws-secure-baseline/issues/152))
- add option to publish VPC Flow Logs to either S3 or CW ([#151](https://github.com/nozaq/terraform-aws-secure-baseline/issues/151))
- associate members to master in SecurityHub ([#147](https://github.com/nozaq/terraform-aws-secure-baseline/issues/147))
- add a flag to enable/disable VPC Flow Logs ([#146](https://github.com/nozaq/terraform-aws-secure-baseline/issues/146))


<a name="0.22.0"></a>
## [0.22.0] - 2020-11-14
### Feat
- apply tags to default network resources ([#133](https://github.com/nozaq/terraform-aws-secure-baseline/issues/133))

### Fix
- logging policies when using custom prefixes ([#141](https://github.com/nozaq/terraform-aws-secure-baseline/issues/141))
- deprecation warnings ([#140](https://github.com/nozaq/terraform-aws-secure-baseline/issues/140))
- prevent AWS Config to fire alarms ([#139](https://github.com/nozaq/terraform-aws-secure-baseline/issues/139))


<a name="0.21.0"></a>
## [0.21.0] - 2020-09-24
### Feat
- various updates to comply with CIS Benchmark v1.3.0 ([#131](https://github.com/nozaq/terraform-aws-secure-baseline/issues/131))
- force using HTTPS to access the access log bucket ([#129](https://github.com/nozaq/terraform-aws-secure-baseline/issues/129))
- force using HTTPS to access the audit log bucket ([#128](https://github.com/nozaq/terraform-aws-secure-baseline/issues/128))
- add parameters to make role creations optional ([#127](https://github.com/nozaq/terraform-aws-secure-baseline/issues/127))
- add tags to guardduty ([#121](https://github.com/nozaq/terraform-aws-secure-baseline/issues/121))
- add tags to flow logs ([#120](https://github.com/nozaq/terraform-aws-secure-baseline/issues/120))

### Fix
- remove a redundant Config rule ([#132](https://github.com/nozaq/terraform-aws-secure-baseline/issues/132))


<a name="0.20.0"></a>
## [0.20.0] - 2020-08-10
### Feat
- make all roles to be optional ([#115](https://github.com/nozaq/terraform-aws-secure-baseline/issues/115))

### Fix
- add a wildcard suffix to log group ARN ([#119](https://github.com/nozaq/terraform-aws-secure-baseline/issues/119))


<a name="0.19.0"></a>
## [0.19.0] - 2020-08-10
### Feat
- new SecurityHub standards support ([#113](https://github.com/nozaq/terraform-aws-secure-baseline/issues/113))
- make delivery of CloudTrail to CloudWatch Logs and SNS optional ([#117](https://github.com/nozaq/terraform-aws-secure-baseline/issues/117))

### Fix
- support standard options for ap-east-1


<a name="0.18.1"></a>
## [0.18.1] - 2020-05-31
### Fix
- do not enable SecurityHub when not enabled ([#111](https://github.com/nozaq/terraform-aws-secure-baseline/issues/111))


<a name="0.18.0"></a>
## [0.18.0] - 2020-05-17
### Feat
- enable Security Hub in each region ([#105](https://github.com/nozaq/terraform-aws-secure-baseline/issues/105))
- encrypt the sns topic ([#103](https://github.com/nozaq/terraform-aws-secure-baseline/issues/103))

### Fix
- use the same CMK for encrypting the SNS topic ([#104](https://github.com/nozaq/terraform-aws-secure-baseline/issues/104))
- ensure to have the audit log bucket before CloudTrail ([#102](https://github.com/nozaq/terraform-aws-secure-baseline/issues/102))
- add in new region ([#91](https://github.com/nozaq/terraform-aws-secure-baseline/issues/91))


<a name="0.17.0"></a>
## [0.17.0] - 2019-12-14

<a name="0.16.2"></a>
## [0.16.2] - 2019-11-16
### Refactor
- remove unused data source


<a name="0.16.1"></a>
## [0.16.1] - 2019-10-12
### Fix
- do not read AWS Organization when account_type is set to "individual"


<a name="0.16.0"></a>
## [0.16.0] - 2019-09-28
### Feat
- add an argument to specify target regions.
- add "tags" argument

### Fix
- incorrect references in external-bucket example


<a name="0.15.0"></a>
## [0.15.0] - 2019-08-18
### Feat
- allow member accounts access to the audit log bucket
- do not setup CloudTrail for member accounts
- add the organizational AWS Config aggregated view
- support organization trails
- support GuardDuty master/member accounts
- only include global resources in the specified region

### Fix
- permissions for organization trail
- do not override guardduty_master_account_id for simplicity
- insufficient permission to accept organization trails.

### Refactor
- use aws_iam_policy_document instead of heredocs


<a name="0.14.0"></a>
## [0.14.0] - 2019-07-24
### Feat
- allow using an external bucket instead of creating a new one
- add a flag to enable force_destroy on S3 buckets


<a name="0.13.0"></a>
## [0.13.0] - 2019-07-14
### Feat
- take finding_publishing_frequency as an input variable
- enable GuardDuty in eu-north-1 region


<a name="0.12.0"></a>
## [0.12.0] - 2019-07-14
### Feat
- return resources as outputs instead of specific attributes


<a name="0.11.0"></a>
## [0.11.0] - 2019-06-06

<a name="0.10.0"></a>
## [0.10.0] - 2019-05-25
### Feat
- upgrade to terraform 0.12


<a name="0.9.0"></a>
## [0.9.0] - 2019-04-06
### Feat
- enable SecurityHub and CIS standard subscription
- add eu-north-1 region support


<a name="0.8.0"></a>
## [0.8.0] - 2019-04-03
### Feat
- add eu-north-1 region support

### Fix
- remove a default subnet resource


<a name="0.7.0"></a>
## [0.7.0] - 2019-02-11
### Fix
- create a log group for VPC Flow Logs in each region


<a name="0.6.0"></a>
## [0.6.0] - 2018-11-23
### Feat
- enable managed config rules for benchmark compliance


<a name="0.5.0"></a>
## [0.5.0] - 2018-08-05
### Feat
- enable GuardDuty in Paris region.

### Fix
- Change how to workaround the default ACL issue.


<a name="0.4.1"></a>
## [0.4.1] - 2018-05-27
### Fix
- create a global rule after recorders.


<a name="0.4.0"></a>
## [0.4.0] - 2018-05-27
### Feat
- enable AWS Config rules for monitoring


<a name="0.3.0"></a>
## [0.3.0] - 2018-05-19
### Feat
- automatically archive audit logs into Amazon Glacier


<a name="0.2.1"></a>
## [0.2.1] - 2018-04-01
### Fix
- temporarily disable mfa_delete on secure buckets


<a name="0.2.0"></a>
## [0.2.0] - 2018-04-01
### Feat
- enable versioning with secure buckets


<a name="0.1.1"></a>
## [0.1.1] - 2018-03-20
### Fix
- omit GuardDuty config for eu-west-3 region until supported


<a name="0.1.0"></a>
## [0.1.0] - 2018-03-11
### Feat
- add various outputs

### Fix
- update var names in the CI script


<a name="0.0.5"></a>
## [0.0.5] - 2018-02-17
### Feat
- add IAM baseline module

### Refactor
- use consistent resource namings


<a name="0.0.4"></a>
## [0.0.4] - 2018-02-12
### Feat
- enable GuardDuty in all regions


<a name="0.0.3"></a>
## [0.0.3] - 2018-02-12
### Feat
- output an ID of the audit log bucket

### Fix
- broken output value


<a name="0.0.2"></a>
## [0.0.2] - 2018-02-12

<a name="0.0.1"></a>
## 0.0.1 - 2018-02-12

[Unreleased]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.23.0...HEAD
[0.23.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.22.0...0.23.0
[0.22.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.21.0...0.22.0
[0.21.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.20.0...0.21.0
[0.20.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.19.0...0.20.0
[0.19.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.18.1...0.19.0
[0.18.1]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.18.0...0.18.1
[0.18.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.17.0...0.18.0
[0.17.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.16.2...0.17.0
[0.16.2]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.16.1...0.16.2
[0.16.1]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.16.0...0.16.1
[0.16.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.15.0...0.16.0
[0.15.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.14.0...0.15.0
[0.14.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.13.0...0.14.0
[0.13.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.12.0...0.13.0
[0.12.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.11.0...0.12.0
[0.11.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.10.0...0.11.0
[0.10.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.9.0...0.10.0
[0.9.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.8.0...0.9.0
[0.8.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.7.0...0.8.0
[0.7.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.6.0...0.7.0
[0.6.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.5.0...0.6.0
[0.5.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.4.1...0.5.0
[0.4.1]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.4.0...0.4.1
[0.4.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.3.0...0.4.0
[0.3.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.2.1...0.3.0
[0.2.1]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.2.0...0.2.1
[0.2.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.1.1...0.2.0
[0.1.1]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.1.0...0.1.1
[0.1.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.0.5...0.1.0
[0.0.5]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.0.4...0.0.5
[0.0.4]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.0.3...0.0.4
[0.0.3]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.0.2...0.0.3
[0.0.2]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.0.1...0.0.2
