### [1.0.1](https://github.com/nozaq/terraform-aws-secure-baseline/compare/v1.0.0...v1.0.1) (2022-03-06)


### Bug Fixes

* avoid for_each key error ([#273](https://github.com/nozaq/terraform-aws-secure-baseline/issues/273)) ([0122d6f](https://github.com/nozaq/terraform-aws-secure-baseline/commit/0122d6fcd00ecd1114a2d5e7853027ebb0322d71))
* mark `var.member_accounts` required ([#272](https://github.com/nozaq/terraform-aws-secure-baseline/issues/272)) ([8612941](https://github.com/nozaq/terraform-aws-secure-baseline/commit/8612941317db8c5f3eb82fd8c5218b8ef5a5d41f))

## [1.0.0] - 2022-02-19
### Feat
- add new S3 bucket configuration resources ([#261](https://github.com/nozaq/terraform-aws-secure-baseline/issues/261))
- allow use of organization trail to be toggled via variable ([#259](https://github.com/nozaq/terraform-aws-secure-baseline/issues/259))

### Fix
- require AWS provider v4.2.0 ([#270](https://github.com/nozaq/terraform-aws-secure-baseline/issues/270))
- require AWS provider v4.1.0 ([#268](https://github.com/nozaq/terraform-aws-secure-baseline/issues/268))
- the condition to use the organization trail ([#265](https://github.com/nozaq/terraform-aws-secure-baseline/issues/265))
- use count instead of `var.enabled` ([#262](https://github.com/nozaq/terraform-aws-secure-baseline/issues/262))

### Refactor
- remove `destination_options` ([#267](https://github.com/nozaq/terraform-aws-secure-baseline/issues/267))
- explicitly define a format for FlowLogs ([#264](https://github.com/nozaq/terraform-aws-secure-baseline/issues/264))
- replace deprecated arguments ([#263](https://github.com/nozaq/terraform-aws-secure-baseline/issues/263))

### BREAKING CHANGE

resources regarding S3 bucket configurations need manual import
after upgrade. See `docs/upgrade-1.0.md` for guidance.


<a name="0.34.0"></a>
## [0.34.0] - 2022-01-22
### Feat
- automatically accepts invite from the master ([#256](https://github.com/nozaq/terraform-aws-secure-baseline/issues/256))
- enforce strong password policy by default ([#252](https://github.com/nozaq/terraform-aws-secure-baseline/issues/252))

### Fix
- no findings aggregator for member accounts ([#257](https://github.com/nozaq/terraform-aws-secure-baseline/issues/257))
- set the minimum terraform version to 1.1.4 ([#255](https://github.com/nozaq/terraform-aws-secure-baseline/issues/255))
- upgrade minimum provider requirements ([#248](https://github.com/nozaq/terraform-aws-secure-baseline/issues/248))


<a name="0.33.0"></a>
## [0.33.0] - 2022-01-10
### Refactor
- add tflint checks ([#246](https://github.com/nozaq/terraform-aws-secure-baseline/issues/246))
- re-organize locals ([#243](https://github.com/nozaq/terraform-aws-secure-baseline/issues/243))


<a name="0.32.0"></a>
## [0.32.0] - 2022-01-08
### Feat
- enable finding aggregator in the main region ([#241](https://github.com/nozaq/terraform-aws-secure-baseline/issues/241))


<a name="0.31.0"></a>
## [0.31.0] - 2022-01-08
### Feat
- add inputs to toggle submodules ([#240](https://github.com/nozaq/terraform-aws-secure-baseline/issues/240))
- optionally ignore SSO logins for MFA alarms ([#234](https://github.com/nozaq/terraform-aws-secure-baseline/issues/234))
- apply default subnet changes to existing subnets ([#237](https://github.com/nozaq/terraform-aws-secure-baseline/issues/237))

### Fix
- use CIS recommended filter pattern ([#239](https://github.com/nozaq/terraform-aws-secure-baseline/issues/239))
- remove `aws_default_vpc` dependency ([#238](https://github.com/nozaq/terraform-aws-secure-baseline/issues/238))

### Refactor
- use module count instead of having ennabled variable in each submodule. ([#195](https://github.com/nozaq/terraform-aws-secure-baseline/issues/195))


<a name="0.30.0"></a>
## [0.30.0] - 2021-11-23
### Feat
- add S3 bucket key support ([#236](https://github.com/nozaq/terraform-aws-secure-baseline/issues/236))

### Fix
- the minimum required version of the AWS provider ([#227](https://github.com/nozaq/terraform-aws-secure-baseline/issues/227))


<a name="0.29.2"></a>
## [0.29.2] - 2021-09-18

<a name="0.29.1"></a>
## [0.29.1] - 2021-09-18
### Fix
- make `sns_topic_kms_master_key_id` optional ([#219](https://github.com/nozaq/terraform-aws-secure-baseline/issues/219))


<a name="0.29.0"></a>
## [0.29.0] - 2021-09-17
### Feat
- add kms_master_key_id to alarm baseline and config-baseline module ([#216](https://github.com/nozaq/terraform-aws-secure-baseline/issues/216))


<a name="0.28.0"></a>
## [0.28.0] - 2021-09-11
### Feat
- GuardDuty: Enable S3 events sources ([#209](https://github.com/nozaq/terraform-aws-secure-baseline/issues/209))
- add support for logging dynamodb events ([#207](https://github.com/nozaq/terraform-aws-secure-baseline/issues/207))
- add in support to enable 3rd party products ([#206](https://github.com/nozaq/terraform-aws-secure-baseline/issues/206))
- adds lambda function invocation logging ([#205](https://github.com/nozaq/terraform-aws-secure-baseline/issues/205))
- add a flag to toggle Security Hub ([#201](https://github.com/nozaq/terraform-aws-secure-baseline/issues/201))

### Fix
- do not manage `datasources` in member accounts. ([#215](https://github.com/nozaq/terraform-aws-secure-baseline/issues/215))
- adjust passwort policy to match CIS 1.3+ ([#214](https://github.com/nozaq/terraform-aws-secure-baseline/issues/214))
- adjust filter pattern for unauthorized_api_calls alarm ([#212](https://github.com/nozaq/terraform-aws-secure-baseline/issues/212))
- adjust passwort policy to match CIS 1.3+ ([#213](https://github.com/nozaq/terraform-aws-secure-baseline/issues/213))
- typo ([#203](https://github.com/nozaq/terraform-aws-secure-baseline/issues/203))


<a name="0.27.1"></a>
## [0.27.1] - 2021-07-03
### Fix
- when VPC is disabled, disable vpc logging for it ([#197](https://github.com/nozaq/terraform-aws-secure-baseline/issues/197))


<a name="0.27.0"></a>
## [0.27.0] - 2021-06-27
### Feat
- add flag for disabling config-baseline ([#190](https://github.com/nozaq/terraform-aws-secure-baseline/issues/190))

### Fix
- is_enabled flag with ap-northeast-3 ([#192](https://github.com/nozaq/terraform-aws-secure-baseline/issues/192))

### Refactor
- define `configuration_aliases` ([#196](https://github.com/nozaq/terraform-aws-secure-baseline/issues/196))
- use `one` instead of `join` to pick the first element ([#194](https://github.com/nozaq/terraform-aws-secure-baseline/issues/194))


<a name="0.26.0"></a>
## [0.26.0] - 2021-06-06
### Feat
- disable automatic public ip assignments in default subnets ([#189](https://github.com/nozaq/terraform-aws-secure-baseline/issues/189))
- enable S3 account-level public block ([#188](https://github.com/nozaq/terraform-aws-secure-baseline/issues/188))
- add functionality to manually enable/disable guardduty-baseline module ([#183](https://github.com/nozaq/terraform-aws-secure-baseline/issues/183))
- enable Insights event logging by default ([#185](https://github.com/nozaq/terraform-aws-secure-baseline/issues/185))
- add cloudtrail insight selector type specification ([#180](https://github.com/nozaq/terraform-aws-secure-baseline/issues/180))
- add vpc_enable variable ([#170](https://github.com/nozaq/terraform-aws-secure-baseline/issues/170))
- add/enable ap-northeast-3 (Osaka) region ([#177](https://github.com/nozaq/terraform-aws-secure-baseline/issues/177))

### Fix
- allow alarm variables to be set at top level module ([#178](https://github.com/nozaq/terraform-aws-secure-baseline/issues/178))


<a name="0.24.0"></a>
## [0.24.0] - 2021-04-25
### Feat
- add flag to allow recording global resources in all regions ([#168](https://github.com/nozaq/terraform-aws-secure-baseline/issues/168))
- enable access analyzer for org ([#167](https://github.com/nozaq/terraform-aws-secure-baseline/issues/167))
- allow enabling/disabling individual alarms ([#164](https://github.com/nozaq/terraform-aws-secure-baseline/issues/164))

### Fix
- edge case when not logging to cloudwatch ([#161](https://github.com/nozaq/terraform-aws-secure-baseline/issues/161))

### Refactor
- define required providers for submodules ([#171](https://github.com/nozaq/terraform-aws-secure-baseline/issues/171))


<a name="0.23.1"></a>
## [0.23.1] - 2020-12-13
### Fix
- invalid reference when flow logs is disabled ([#157](https://github.com/nozaq/terraform-aws-secure-baseline/issues/157))


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

[Unreleased]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/1.0.0...HEAD
[1.0.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.34.0...1.0.0
[0.34.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.33.0...0.34.0
[0.33.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.32.0...0.33.0
[0.32.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.31.0...0.32.0
[0.31.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.30.0...0.31.0
[0.30.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.29.2...0.30.0
[0.29.2]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.29.1...0.29.2
[0.29.1]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.29.0...0.29.1
[0.29.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.28.0...0.29.0
[0.28.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.27.1...0.28.0
[0.27.1]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.27.0...0.27.1
[0.27.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.26.0...0.27.0
[0.26.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.24.0...0.26.0
[0.24.0]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.23.1...0.24.0
[0.23.1]: https://github.com/nozaq/terraform-aws-secure-baseline/compare/0.23.0...0.23.1
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
