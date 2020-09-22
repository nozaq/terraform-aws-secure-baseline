# --------------------------------------------------------------------------------------------------
# The SNS topic to which CloudWatch alarms send events.
# --------------------------------------------------------------------------------------------------

resource "aws_sns_topic" "alarms" {
  count = var.enabled ? 1 : 0

  name = var.sns_topic_name

  tags = var.tags
}

# --------------------------------------------------------------------------------------------------
# CloudWatch metrics and alamrs defined in the CIS benchmark.
# --------------------------------------------------------------------------------------------------

resource "aws_cloudwatch_log_metric_filter" "unauthorized_api_calls" {
  count = var.enabled ? 1 : 0

  name           = "UnauthorizedAPICalls"
  pattern        = "{ ($.errorCode = \"*UnauthorizedOperation\") || ($.errorCode = \"AccessDenied*\") }"
  log_group_name = var.cloudtrail_log_group_name

  metric_transformation {
    name      = "UnauthorizedAPICalls"
    namespace = var.alarm_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "unauthorized_api_calls" {
  count = var.enabled ? 1 : 0

  alarm_name                = "UnauthorizedAPICalls"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.unauthorized_api_calls[0].id
  namespace                 = var.alarm_namespace
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring unauthorized API calls will help reveal application errors and may reduce time to detect malicious activity."
  alarm_actions             = [aws_sns_topic.alarms[0].arn]
  treat_missing_data        = "notBreaching"
  insufficient_data_actions = []

  tags = var.tags
}

resource "aws_cloudwatch_log_metric_filter" "no_mfa_console_signin" {
  count = var.enabled ? 1 : 0

  name           = "NoMFAConsoleSignin"
  pattern        = "{ ($.eventName = \"ConsoleLogin\") && ($.additionalEventData.MFAUsed != \"Yes\") }"
  log_group_name = var.cloudtrail_log_group_name

  metric_transformation {
    name      = "NoMFAConsoleSignin"
    namespace = var.alarm_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "no_mfa_console_signin" {
  count = var.enabled ? 1 : 0

  alarm_name                = "NoMFAConsoleSignin"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.no_mfa_console_signin[0].id
  namespace                 = var.alarm_namespace
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring for single-factor console logins will increase visibility into accounts that are not protected by MFA."
  alarm_actions             = [aws_sns_topic.alarms[0].arn]
  treat_missing_data        = "notBreaching"
  insufficient_data_actions = []

  tags = var.tags
}

resource "aws_cloudwatch_log_metric_filter" "root_usage" {
  count = var.enabled ? 1 : 0

  name           = "RootUsage"
  pattern        = "{ $.userIdentity.type = \"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType != \"AwsServiceEvent\" }"
  log_group_name = var.cloudtrail_log_group_name

  metric_transformation {
    name      = "RootUsage"
    namespace = var.alarm_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "root_usage" {
  count = var.enabled ? 1 : 0

  alarm_name                = "RootUsage"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.root_usage[0].id
  namespace                 = var.alarm_namespace
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring for root account logins will provide visibility into the use of a fully privileged account and an opportunity to reduce the use of it."
  alarm_actions             = [aws_sns_topic.alarms[0].arn]
  treat_missing_data        = "notBreaching"
  insufficient_data_actions = []

  tags = var.tags
}

resource "aws_cloudwatch_log_metric_filter" "iam_changes" {
  count = var.enabled ? 1 : 0

  name           = "IAMChanges"
  pattern        = "{($.eventName=DeleteGroupPolicy)||($.eventName=DeleteRolePolicy)||($.eventName=DeleteUserPolicy)||($.eventName=PutGroupPolicy)||($.eventName=PutRolePolicy)||($.eventName=PutUserPolicy)||($.eventName=CreatePolicy)||($.eventName=DeletePolicy)||($.eventName=CreatePolicyVersion)||($.eventName=DeletePolicyVersion)||($.eventName=AttachRolePolicy)||($.eventName=DetachRolePolicy)||($.eventName=AttachUserPolicy)||($.eventName=DetachUserPolicy)||($.eventName=AttachGroupPolicy)||($.eventName=DetachGroupPolicy)}"
  log_group_name = var.cloudtrail_log_group_name

  metric_transformation {
    name      = "IAMChanges"
    namespace = var.alarm_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "iam_changes" {
  count = var.enabled ? 1 : 0

  alarm_name                = "IAMChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.iam_changes[0].id
  namespace                 = var.alarm_namespace
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring changes to IAM policies will help ensure authentication and authorization controls remain intact."
  alarm_actions             = [aws_sns_topic.alarms[0].arn]
  treat_missing_data        = "notBreaching"
  insufficient_data_actions = []

  tags = var.tags
}

resource "aws_cloudwatch_log_metric_filter" "cloudtrail_cfg_changes" {
  count = var.enabled ? 1 : 0

  name           = "CloudTrailCfgChanges"
  pattern        = "{ ($.eventName = CreateTrail) || ($.eventName = UpdateTrail) || ($.eventName = DeleteTrail) || ($.eventName = StartLogging) || ($.eventName = StopLogging) }"
  log_group_name = var.cloudtrail_log_group_name

  metric_transformation {
    name      = "CloudTrailCfgChanges"
    namespace = var.alarm_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "cloudtrail_cfg_changes" {
  count = var.enabled ? 1 : 0

  alarm_name                = "CloudTrailCfgChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.cloudtrail_cfg_changes[0].id
  namespace                 = var.alarm_namespace
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring changes to CloudTrail's configuration will help ensure sustained visibility to activities performed in the AWS account."
  alarm_actions             = [aws_sns_topic.alarms[0].arn]
  treat_missing_data        = "notBreaching"
  insufficient_data_actions = []

  tags = var.tags
}

resource "aws_cloudwatch_log_metric_filter" "console_signin_failures" {
  count = var.enabled ? 1 : 0

  name           = "ConsoleSigninFailures"
  pattern        = "{ ($.eventName = ConsoleLogin) && ($.errorMessage = \"Failed authentication\") }"
  log_group_name = var.cloudtrail_log_group_name

  metric_transformation {
    name      = "ConsoleSigninFailures"
    namespace = var.alarm_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "console_signin_failures" {
  count = var.enabled ? 1 : 0

  alarm_name                = "ConsoleSigninFailures"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.console_signin_failures[0].id
  namespace                 = var.alarm_namespace
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring failed console logins may decrease lead time to detect an attempt to brute force a credential, which may provide an indicator, such as source IP, that can be used in other event correlation."
  alarm_actions             = [aws_sns_topic.alarms[0].arn]
  treat_missing_data        = "notBreaching"
  insufficient_data_actions = []

  tags = var.tags
}

resource "aws_cloudwatch_log_metric_filter" "disable_or_delete_cmk" {
  count = var.enabled ? 1 : 0

  name           = "DisableOrDeleteCMK"
  pattern        = "{ ($.eventSource = kms.amazonaws.com) && (($.eventName = DisableKey) || ($.eventName = ScheduleKeyDeletion)) }"
  log_group_name = var.cloudtrail_log_group_name

  metric_transformation {
    name      = "DisableOrDeleteCMK"
    namespace = var.alarm_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "disable_or_delete_cmk" {
  count = var.enabled ? 1 : 0

  alarm_name                = "DisableOrDeleteCMK"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.disable_or_delete_cmk[0].id
  namespace                 = var.alarm_namespace
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring failed console logins may decrease lead time to detect an attempt to brute force a credential, which may provide an indicator, such as source IP, that can be used in other event correlation."
  alarm_actions             = [aws_sns_topic.alarms[0].arn]
  treat_missing_data        = "notBreaching"
  insufficient_data_actions = []

  tags = var.tags
}

resource "aws_cloudwatch_log_metric_filter" "s3_bucket_policy_changes" {
  count = var.enabled ? 1 : 0

  name           = "S3BucketPolicyChanges"
  pattern        = "{ ($.eventSource = s3.amazonaws.com) && (($.eventName = PutBucketAcl) || ($.eventName = PutBucketPolicy) || ($.eventName = PutBucketCors) || ($.eventName = PutBucketLifecycle) || ($.eventName = PutBucketReplication) || ($.eventName = DeleteBucketPolicy) || ($.eventName = DeleteBucketCors) || ($.eventName = DeleteBucketLifecycle) || ($.eventName = DeleteBucketReplication)) }"
  log_group_name = var.cloudtrail_log_group_name

  metric_transformation {
    name      = "S3BucketPolicyChanges"
    namespace = var.alarm_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "s3_bucket_policy_changes" {
  count = var.enabled ? 1 : 0

  alarm_name                = "S3BucketPolicyChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.s3_bucket_policy_changes[0].id
  namespace                 = var.alarm_namespace
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring changes to S3 bucket policies may reduce time to detect and correct permissive policies on sensitive S3 buckets."
  alarm_actions             = [aws_sns_topic.alarms[0].arn]
  treat_missing_data        = "notBreaching"
  insufficient_data_actions = []

  tags = var.tags
}

resource "aws_cloudwatch_log_metric_filter" "aws_config_changes" {
  count = var.enabled ? 1 : 0

  name           = "AWSConfigChanges"
  pattern        = "{ ($.eventSource = config.amazonaws.com) && (($.eventName=StopConfigurationRecorder)||($.eventName=DeleteDeliveryChannel)||($.eventName=PutDeliveryChannel)||($.eventName=PutConfigurationRecorder)) }"
  log_group_name = var.cloudtrail_log_group_name

  metric_transformation {
    name      = "AWSConfigChanges"
    namespace = var.alarm_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "aws_config_changes" {
  count = var.enabled ? 1 : 0

  alarm_name                = "AWSConfigChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.aws_config_changes[0].id
  namespace                 = var.alarm_namespace
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring changes to AWS Config configuration will help ensure sustained visibility of configuration items within the AWS account."
  alarm_actions             = [aws_sns_topic.alarms[0].arn]
  treat_missing_data        = "notBreaching"
  insufficient_data_actions = []

  tags = var.tags
}

resource "aws_cloudwatch_log_metric_filter" "security_group_changes" {
  count = var.enabled ? 1 : 0

  name           = "SecurityGroupChanges"
  pattern        = "{ ($.eventName = AuthorizeSecurityGroupIngress) || ($.eventName = AuthorizeSecurityGroupEgress) || ($.eventName = RevokeSecurityGroupIngress) || ($.eventName = RevokeSecurityGroupEgress) || ($.eventName = CreateSecurityGroup) || ($.eventName = DeleteSecurityGroup)}"
  log_group_name = var.cloudtrail_log_group_name

  metric_transformation {
    name      = "SecurityGroupChanges"
    namespace = var.alarm_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "security_group_changes" {
  count = var.enabled ? 1 : 0

  alarm_name                = "SecurityGroupChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.security_group_changes[0].id
  namespace                 = var.alarm_namespace
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring changes to security group will help ensure that resources and services are not unintentionally exposed."
  alarm_actions             = [aws_sns_topic.alarms[0].arn]
  treat_missing_data        = "notBreaching"
  insufficient_data_actions = []

  tags = var.tags
}

resource "aws_cloudwatch_log_metric_filter" "nacl_changes" {
  count = var.enabled ? 1 : 0

  name           = "NACLChanges"
  pattern        = "{ ($.eventName = CreateNetworkAcl) || ($.eventName = CreateNetworkAclEntry) || ($.eventName = DeleteNetworkAcl) || ($.eventName = DeleteNetworkAclEntry) || ($.eventName = ReplaceNetworkAclEntry) || ($.eventName = ReplaceNetworkAclAssociation) }"
  log_group_name = var.cloudtrail_log_group_name

  metric_transformation {
    name      = "NACLChanges"
    namespace = var.alarm_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "nacl_changes" {
  count = var.enabled ? 1 : 0

  alarm_name                = "NACLChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.nacl_changes[0].id
  namespace                 = var.alarm_namespace
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring changes to NACLs will help ensure that AWS resources and services are not unintentionally exposed."
  alarm_actions             = [aws_sns_topic.alarms[0].arn]
  treat_missing_data        = "notBreaching"
  insufficient_data_actions = []

  tags = var.tags
}

resource "aws_cloudwatch_log_metric_filter" "network_gw_changes" {
  count = var.enabled ? 1 : 0

  name           = "NetworkGWChanges"
  pattern        = "{ ($.eventName = CreateCustomerGateway) || ($.eventName = DeleteCustomerGateway) || ($.eventName = AttachInternetGateway) || ($.eventName = CreateInternetGateway) || ($.eventName = DeleteInternetGateway) || ($.eventName = DetachInternetGateway) }"
  log_group_name = var.cloudtrail_log_group_name

  metric_transformation {
    name      = "NetworkGWChanges"
    namespace = var.alarm_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "network_gw_changes" {
  count = var.enabled ? 1 : 0

  alarm_name                = "NetworkGWChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.network_gw_changes[0].id
  namespace                 = var.alarm_namespace
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring changes to network gateways will help ensure that all ingress/egress traffic traverses the VPC border via a controlled path."
  alarm_actions             = [aws_sns_topic.alarms[0].arn]
  treat_missing_data        = "notBreaching"
  insufficient_data_actions = []

  tags = var.tags
}

resource "aws_cloudwatch_log_metric_filter" "route_table_changes" {
  count = var.enabled ? 1 : 0

  name           = "RouteTableChanges"
  pattern        = "{ ($.eventName = CreateRoute) || ($.eventName = CreateRouteTable) || ($.eventName = ReplaceRoute) || ($.eventName = ReplaceRouteTableAssociation) || ($.eventName = DeleteRouteTable) || ($.eventName = DeleteRoute) || ($.eventName = DisassociateRouteTable) }"
  log_group_name = var.cloudtrail_log_group_name

  metric_transformation {
    name      = "RouteTableChanges"
    namespace = var.alarm_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "route_table_changes" {
  count = var.enabled ? 1 : 0

  alarm_name                = "RouteTableChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.route_table_changes[0].id
  namespace                 = var.alarm_namespace
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring changes to route tables will help ensure that all VPC traffic flows through an expected path."
  alarm_actions             = [aws_sns_topic.alarms[0].arn]
  treat_missing_data        = "notBreaching"
  insufficient_data_actions = []

  tags = var.tags
}

resource "aws_cloudwatch_log_metric_filter" "vpc_changes" {
  count = var.enabled ? 1 : 0

  name           = "VPCChanges"
  pattern        = "{ ($.eventName = CreateVpc) || ($.eventName = DeleteVpc) || ($.eventName = ModifyVpcAttribute) || ($.eventName = AcceptVpcPeeringConnection) || ($.eventName = CreateVpcPeeringConnection) || ($.eventName = DeleteVpcPeeringConnection) || ($.eventName = RejectVpcPeeringConnection) || ($.eventName = AttachClassicLinkVpc) || ($.eventName = DetachClassicLinkVpc) || ($.eventName = DisableVpcClassicLink) || ($.eventName = EnableVpcClassicLink) }"
  log_group_name = var.cloudtrail_log_group_name

  metric_transformation {
    name      = "VPCChanges"
    namespace = var.alarm_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "vpc_changes" {
  count = var.enabled ? 1 : 0

  alarm_name                = "VPCChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.vpc_changes[0].id
  namespace                 = var.alarm_namespace
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring changes to VPC will help ensure that all VPC traffic flows through an expected path."
  alarm_actions             = [aws_sns_topic.alarms[0].arn]
  treat_missing_data        = "notBreaching"
  insufficient_data_actions = []

  tags = var.tags
}

resource "aws_cloudwatch_log_metric_filter" "organizations_changes" {
  count = var.enabled ? 1 : 0

  name           = "OrganizationsChanges"
  pattern        = "{ ($.eventSource = organizations.amazonaws.com) && (($.eventName = \"AcceptHandshake\") || ($.eventName = \"AttachPolicy\") || ($.eventName = \"CreateAccount\") || ($.eventName = \"CreateOrganizationalUnit\") || ($.eventName= \"CreatePolicy\") || ($.eventName = \"DeclineHandshake\") || ($.eventName = \"DeleteOrganization\") || ($.eventName = \"DeleteOrganizationalUnit\") || ($.eventName = \"DeletePolicy\") || ($.eventName = \"DetachPolicy\") || ($.eventName = \"DisablePolicyType\") || ($.eventName = \"EnablePolicyType\") || ($.eventName = \"InviteAccountToOrganization\") || ($.eventName = \"LeaveOrganization\") || ($.eventName = \"MoveAccount\") || ($.eventName = \"RemoveAccountFromOrganization\") || ($.eventName = \"UpdatePolicy\") || ($.eventName =\"UpdateOrganizationalUnit\")) }"
  log_group_name = var.cloudtrail_log_group_name

  metric_transformation {
    name      = "OrganizationsChanges"
    namespace = var.alarm_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "organizations_changes" {
  count = var.enabled ? 1 : 0

  alarm_name                = "OrganizationsChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.organizations_changes[0].id
  namespace                 = var.alarm_namespace
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring AWS Organizations changes can help you prevent any unwanted, accidental or intentional modifications that may lead to unauthorized access or other security breaches."
  alarm_actions             = [aws_sns_topic.alarms[0].arn]
  treat_missing_data        = "notBreaching"
  insufficient_data_actions = []

  tags = var.tags
}
