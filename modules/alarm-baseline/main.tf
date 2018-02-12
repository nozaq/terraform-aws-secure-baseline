resource "aws_sns_topic" "alarms" {
  name = "${var.sns_topic_name}"
}

resource "aws_cloudwatch_log_metric_filter" "unauthorized-api-calls" {
  name           = "UnauthorizedAPICalls"
  pattern        = "{ ($.errorCode = \"*UnauthorizedOperation\") || ($.errorCode = \"AccessDenied*\") }"
  log_group_name = "${var.cloudtrail_log_group_name}"

  metric_transformation {
    name      = "UnauthorizedAPICalls"
    namespace = "${var.alarm_namespace}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "unauthorized-api-calls" {
  alarm_name                = "UnauthorizedAPICalls"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "${aws_cloudwatch_log_metric_filter.unauthorized-api-calls.id}"
  namespace                 = "${var.alarm_namespace}"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring unauthorized API calls will help reveal application errors and may reduce time to detect malicious activity."
  alarm_actions             = ["${aws_sns_topic.alarms.arn}"]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_log_metric_filter" "no-mfa-console-signin" {
  name           = "NoMFAConsoleSignin"
  pattern        = "{ ($.eventName = \"ConsoleLogin\") && ($.additionalEventData.MFAUsed != \"Yes\") }"
  log_group_name = "${var.cloudtrail_log_group_name}"

  metric_transformation {
    name      = "NoMFAConsoleSignin"
    namespace = "${var.alarm_namespace}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "no-mfa-console-signin" {
  alarm_name                = "NoMFAConsoleSignin"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "${aws_cloudwatch_log_metric_filter.no-mfa-console-signin.id}"
  namespace                 = "${var.alarm_namespace}"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring for single-factor console logins will increase visibility into accounts that are not protected by MFA."
  alarm_actions             = ["${aws_sns_topic.alarms.arn}"]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_log_metric_filter" "root-usage" {
  name           = "RootUsage"
  pattern        = "{ $.userIdentity.type = \"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType != \"AwsServiceEvent\" }"
  log_group_name = "${var.cloudtrail_log_group_name}"

  metric_transformation {
    name      = "RootUsage"
    namespace = "${var.alarm_namespace}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "root-usage" {
  alarm_name                = "RootUsage"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "${aws_cloudwatch_log_metric_filter.root-usage.id}"
  namespace                 = "${var.alarm_namespace}"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring for root account logins will provide visibility into the use of a fully privileged account and an opportunity to reduce the use of it."
  alarm_actions             = ["${aws_sns_topic.alarms.arn}"]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_log_metric_filter" "iam-changes" {
  name           = "IAMChanges"
  pattern        = "{($.eventName=DeleteGroupPolicy)||($.eventName=DeleteRolePolicy)||($.eventName=DeleteUserPolicy)||($.eventName=PutGroupPolicy)||($.eventName=PutRolePolicy)||($.eventName=PutUserPolicy)||($.eventName=CreatePolicy)||($.eventName=DeletePolicy)||($.eventName=CreatePolicyVersion)||($.eventName=DeletePolicyVersion)||($.eventName=AttachRolePolicy)||($.eventName=DetachRolePolicy)||($.eventName=AttachUserPolicy)||($.eventName=DetachUserPolicy)||($.eventName=AttachGroupPolicy)||($.eventName=DetachGroupPolicy)}"
  log_group_name = "${var.cloudtrail_log_group_name}"

  metric_transformation {
    name      = "IAMChanges"
    namespace = "${var.alarm_namespace}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "iam-changes" {
  alarm_name                = "IAMChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "${aws_cloudwatch_log_metric_filter.iam-changes.id}"
  namespace                 = "${var.alarm_namespace}"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring changes to IAM policies will help ensure authentication and authorization controls remain intact."
  alarm_actions             = ["${aws_sns_topic.alarms.arn}"]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_log_metric_filter" "cloudtrail-cfg-changes" {
  name           = "CloudTrailCfgChanges"
  pattern        = "{ ($.eventName = CreateTrail) || ($.eventName = UpdateTrail) || ($.eventName = DeleteTrail) || ($.eventName = StartLogging) || ($.eventName = StopLogging) }"
  log_group_name = "${var.cloudtrail_log_group_name}"

  metric_transformation {
    name      = "CloudTrailCfgChanges"
    namespace = "${var.alarm_namespace}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "cloudtrail-cfg-changes" {
  alarm_name                = "CloudTrailCfgChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "${aws_cloudwatch_log_metric_filter.cloudtrail-cfg-changes.id}"
  namespace                 = "${var.alarm_namespace}"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring changes to CloudTrail's configuration will help ensure sustained visibility to activities performed in the AWS account."
  alarm_actions             = ["${aws_sns_topic.alarms.arn}"]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_log_metric_filter" "console-signin-failures" {
  name           = "ConsoleSigninFailures"
  pattern        = "{ ($.eventName = ConsoleLogin) && ($.errorMessage = \"Failed authentication\") }"
  log_group_name = "${var.cloudtrail_log_group_name}"

  metric_transformation {
    name      = "ConsoleSigninFailures"
    namespace = "${var.alarm_namespace}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "console-signin-failures" {
  alarm_name                = "ConsoleSigninFailures"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "${aws_cloudwatch_log_metric_filter.console-signin-failures.id}"
  namespace                 = "${var.alarm_namespace}"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring failed console logins may decrease lead time to detect an attempt to brute force a credential, which may provide an indicator, such as source IP, that can be used in other event correlation."
  alarm_actions             = ["${aws_sns_topic.alarms.arn}"]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_log_metric_filter" "disable-or-delete-cmk" {
  name           = "DisableOrDeleteCMK"
  pattern        = "{ ($.eventSource = kms.amazonaws.com) && (($.eventName = DisableKey) || ($.eventName = ScheduleKeyDeletion)) }"
  log_group_name = "${var.cloudtrail_log_group_name}"

  metric_transformation {
    name      = "DisableOrDeleteCMK"
    namespace = "${var.alarm_namespace}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "disable-or-delete-cmk" {
  alarm_name                = "DisableOrDeleteCMK"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "${aws_cloudwatch_log_metric_filter.disable-or-delete-cmk.id}"
  namespace                 = "${var.alarm_namespace}"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring failed console logins may decrease lead time to detect an attempt to brute force a credential, which may provide an indicator, such as source IP, that can be used in other event correlation."
  alarm_actions             = ["${aws_sns_topic.alarms.arn}"]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_log_metric_filter" "s3-bucket-policy-changes" {
  name           = "S3BucketPolicyChanges"
  pattern        = "{ ($.eventSource = s3.amazonaws.com) && (($.eventName = PutBucketAcl) || ($.eventName = PutBucketPolicy) || ($.eventName = PutBucketCors) || ($.eventName = PutBucketLifecycle) || ($.eventName = PutBucketReplication) || ($.eventName = DeleteBucketPolicy) || ($.eventName = DeleteBucketCors) || ($.eventName = DeleteBucketLifecycle) || ($.eventName = DeleteBucketReplication)) }"
  log_group_name = "${var.cloudtrail_log_group_name}"

  metric_transformation {
    name      = "S3BucketPolicyChanges"
    namespace = "${var.alarm_namespace}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "s3-bucket-policy-changes" {
  alarm_name                = "S3BucketPolicyChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "${aws_cloudwatch_log_metric_filter.s3-bucket-policy-changes.id}"
  namespace                 = "${var.alarm_namespace}"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring changes to S3 bucket policies may reduce time to detect and correct permissive policies on sensitive S3 buckets."
  alarm_actions             = ["${aws_sns_topic.alarms.arn}"]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_log_metric_filter" "aws-config-changes" {
  name           = "AWSConfigChanges"
  pattern        = "{ ($.eventSource = config.amazonaws.com) && (($.eventName=StopConfigurationRecorder)||($.eventName=DeleteDeliveryChannel)||($.eventName=PutDeliveryChannel)||($.eventName=PutConfigurationRecorder)) }"
  log_group_name = "${var.cloudtrail_log_group_name}"

  metric_transformation {
    name      = "AWSConfigChanges"
    namespace = "${var.alarm_namespace}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "aws-config-changes" {
  alarm_name                = "AWSConfigChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "${aws_cloudwatch_log_metric_filter.aws-config-changes.id}"
  namespace                 = "${var.alarm_namespace}"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring changes to AWS Config configuration will help ensure sustained visibility of configuration items within the AWS account."
  alarm_actions             = ["${aws_sns_topic.alarms.arn}"]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_log_metric_filter" "security-group-changes" {
  name           = "SecurityGroupChanges"
  pattern        = "{ ($.eventName = AuthorizeSecurityGroupIngress) || ($.eventName = AuthorizeSecurityGroupEgress) || ($.eventName = RevokeSecurityGroupIngress) || ($.eventName = RevokeSecurityGroupEgress) || ($.eventName = CreateSecurityGroup) || ($.eventName = DeleteSecurityGroup)}"
  log_group_name = "${var.cloudtrail_log_group_name}"

  metric_transformation {
    name      = "SecurityGroupChanges"
    namespace = "${var.alarm_namespace}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "security-group-changes" {
  alarm_name                = "SecurityGroupChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "${aws_cloudwatch_log_metric_filter.security-group-changes.id}"
  namespace                 = "${var.alarm_namespace}"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring changes to security group will help ensure that resources and services are not unintentionally exposed."
  alarm_actions             = ["${aws_sns_topic.alarms.arn}"]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_log_metric_filter" "nacl-changes" {
  name           = "NACLChanges"
  pattern        = "{ ($.eventName = CreateNetworkAcl) || ($.eventName = CreateNetworkAclEntry) || ($.eventName = DeleteNetworkAcl) || ($.eventName = DeleteNetworkAclEntry) || ($.eventName = ReplaceNetworkAclEntry) || ($.eventName = ReplaceNetworkAclAssociation) }"
  log_group_name = "${var.cloudtrail_log_group_name}"

  metric_transformation {
    name      = "NACLChanges"
    namespace = "${var.alarm_namespace}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "nacl-changes" {
  alarm_name                = "NACLChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "${aws_cloudwatch_log_metric_filter.nacl-changes.id}"
  namespace                 = "${var.alarm_namespace}"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring changes to NACLs will help ensure that AWS resources and services are not unintentionally exposed."
  alarm_actions             = ["${aws_sns_topic.alarms.arn}"]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_log_metric_filter" "network-gw-changes" {
  name           = "NetworkGWChanges"
  pattern        = "{ ($.eventName = CreateCustomerGateway) || ($.eventName = DeleteCustomerGateway) || ($.eventName = AttachInternetGateway) || ($.eventName = CreateInternetGateway) || ($.eventName = DeleteInternetGateway) || ($.eventName = DetachInternetGateway) }"
  log_group_name = "${var.cloudtrail_log_group_name}"

  metric_transformation {
    name      = "NetworkGWChanges"
    namespace = "${var.alarm_namespace}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "network-gw-changes" {
  alarm_name                = "NetworkGWChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "${aws_cloudwatch_log_metric_filter.network-gw-changes.id}"
  namespace                 = "${var.alarm_namespace}"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring changes to network gateways will help ensure that all ingress/egress traffic traverses the VPC border via a controlled path."
  alarm_actions             = ["${aws_sns_topic.alarms.arn}"]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_log_metric_filter" "route-table-changes" {
  name           = "RouteTableChanges"
  pattern        = "{ ($.eventName = CreateRoute) || ($.eventName = CreateRouteTable) || ($.eventName = ReplaceRoute) || ($.eventName = ReplaceRouteTableAssociation) || ($.eventName = DeleteRouteTable) || ($.eventName = DeleteRoute) || ($.eventName = DisassociateRouteTable) }"
  log_group_name = "${var.cloudtrail_log_group_name}"

  metric_transformation {
    name      = "RouteTableChanges"
    namespace = "${var.alarm_namespace}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "route-table-changes" {
  alarm_name                = "RouteTableChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "${aws_cloudwatch_log_metric_filter.route-table-changes.id}"
  namespace                 = "${var.alarm_namespace}"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring changes to route tables will help ensure that all VPC traffic flows through an expected path."
  alarm_actions             = ["${aws_sns_topic.alarms.arn}"]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_log_metric_filter" "vpc-changes" {
  name           = "VPCChanges"
  pattern        = "{ ($.eventName = CreateVpc) || ($.eventName = DeleteVpc) || ($.eventName = ModifyVpcAttribute) || ($.eventName = AcceptVpcPeeringConnection) || ($.eventName = CreateVpcPeeringConnection) || ($.eventName = DeleteVpcPeeringConnection) || ($.eventName = RejectVpcPeeringConnection) || ($.eventName = AttachClassicLinkVpc) || ($.eventName = DetachClassicLinkVpc) || ($.eventName = DisableVpcClassicLink) || ($.eventName = EnableVpcClassicLink) }"
  log_group_name = "${var.cloudtrail_log_group_name}"

  metric_transformation {
    name      = "VPCChanges"
    namespace = "${var.alarm_namespace}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "vpc-changes" {
  alarm_name                = "VPCChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "${aws_cloudwatch_log_metric_filter.vpc-changes.id}"
  namespace                 = "${var.alarm_namespace}"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring changes to VPC will help ensure that all VPC traffic flows through an expected path."
  alarm_actions             = ["${aws_sns_topic.alarms.arn}"]
  insufficient_data_actions = []
}
