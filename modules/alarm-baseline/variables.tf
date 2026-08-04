variable "unauthorized_api_calls_enabled" {
  description = "The boolean flag whether the unauthorized_api_calls alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "no_mfa_console_signin_enabled" {
  description = "The boolean flag whether the no_mfa_console_signin alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "mfa_console_signin_allow_sso" {
  description = "The boolean flag whether the no_mfa_console_signin alarm allows SSO auth to be ignored."
  type        = bool
  default     = false
}

variable "root_usage_enabled" {
  description = "The boolean flag whether the root_usage alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "iam_changes_enabled" {
  description = "The boolean flag whether the iam_changes alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "cloudtrail_cfg_changes_enabled" {
  description = "The boolean flag whether the cloudtrail_cfg_changes alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "console_signin_failures_enabled" {
  description = "The boolean flag whether the console_signin_failures alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "disable_or_delete_cmk_enabled" {
  description = "The boolean flag whether the disable_or_delete_cmk alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "s3_bucket_policy_changes_enabled" {
  description = "The boolean flag whether the s3_bucket_policy_changes alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "aws_config_changes_enabled" {
  description = "The boolean flag whether the aws_config_changes alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "security_group_changes_enabled" {
  description = "The boolean flag whether the security_group_changes alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "nacl_changes_enabled" {
  description = "The boolean flag whether the nacl_changes alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "network_gw_changes_enabled" {
  description = "The boolean flag whether the network_gw_changes alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "route_table_changes_enabled" {
  description = "The boolean flag whether the route_table_changes alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "vpc_changes_enabled" {
  description = "The boolean flag whether the vpc_changes alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "organizations_changes_enabled" {
  description = "The boolean flag whether the organizations_changes alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "alarm_namespace" {
  description = "The namespace in which all alarms are set up."
  type        = string
  default     = "CISBenchmark"
}

variable "cloudtrail_log_group_name" {
  description = "The name of the CloudWatch Logs group to which CloudTrail events are delivered."
  type        = string
}

variable "sns_topic_name" {
  description = "The name of the SNS Topic which will be notified when any alarm is performed."
  type        = string
  default     = "CISAlarm"
}

variable "sns_topic_kms_master_key_id" {
  description = "To enable SNS Topic encryption enter value with the ID of a custom master KMS key that is used for encryption"
  type        = string
  default     = null
}

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  type        = map(string)
  default     = {
    "Terraform" = "true"
  }
}

variable "unauthorized_api_calls_pattern" {
  description = "Pattern for unauthorized api calls"
  type        = string
  default     = "{(($.errorCode = \"*UnauthorizedOperation\") || ($.errorCode = \"AccessDenied*\")) && (($.sourceIPAddress!=\"delivery.logs.amazonaws.com\") && ($.eventName!=\"HeadBucket\"))}"
}

variable "no_mfa_console_signin_pattern" {
  description = "Pattern for No MFA console signin"
  type        = string
  default     = join(" ", [
    "{ ($.eventName = \"ConsoleLogin\") && ($.additionalEventData.MFAUsed != \"Yes\")",
    var.mfa_console_signin_allow_sso ? "&& ($.userIdentity.type = \"IAMUser\") && ($.responseElements.ConsoleLogin = \"Success\") }" : "}",
  ])
}

variable "root_usage_pattern" {
  description = "Pattern for root usage"
  type        = string
  default     = "{ $.userIdentity.type = \"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType != \"AwsServiceEvent\" }"
}

variable "iam_changes_pattern" {
  description = ""
  type        = string
  default     = "{($.eventName=DeleteGroupPolicy)||($.eventName=DeleteRolePolicy)||($.eventName=DeleteUserPolicy)||($.eventName=PutGroupPolicy)||($.eventName=PutRolePolicy)||($.eventName=PutUserPolicy)||($.eventName=CreatePolicy)||($.eventName=DeletePolicy)||($.eventName=CreatePolicyVersion)||($.eventName=DeletePolicyVersion)||($.eventName=AttachRolePolicy)||($.eventName=DetachRolePolicy)||($.eventName=AttachUserPolicy)||($.eventName=DetachUserPolicy)||($.eventName=AttachGroupPolicy)||($.eventName=DetachGroupPolicy)}"
}

variable "cloudtrail_cfg_changes_pattern" {
  description = "Pattern for CloudTrail config changes"
  type        = string
  default     = "{ ($.eventName = CreateTrail) || ($.eventName = UpdateTrail) || ($.eventName = DeleteTrail) || ($.eventName = StartLogging) || ($.eventName = StopLogging) }"
}

variable "console_signin_failures_pattern" {
  description = "Pattern for Console signin failures"
  type        = string
  default     = "{ ($.eventName = ConsoleLogin) && ($.errorMessage = \"Failed authentication\") }"
}

variable "disable_or_delete_cmk_pattern" {
  description = "Pattern for Disable or Delete cmk"
  type        = string
  default     = "{ ($.eventSource = kms.amazonaws.com) && (($.eventName = DisableKey) || ($.eventName = ScheduleKeyDeletion)) }"
}

variable "s3_bucket_policy_changes_pattern" {
  description = "Pattern for S3 Bucket Policy changes"
  type        = string
  default     = "{ ($.eventSource = s3.amazonaws.com) && (($.eventName = PutBucketAcl) || ($.eventName = PutBucketPolicy) || ($.eventName = PutBucketCors) || ($.eventName = PutBucketLifecycle) || ($.eventName = PutBucketReplication) || ($.eventName = DeleteBucketPolicy) || ($.eventName = DeleteBucketCors) || ($.eventName = DeleteBucketLifecycle) || ($.eventName = DeleteBucketReplication)) }"
}

variable "aws_config_changes_pattern" {
  description = "Pattern for AWS Config changes"
  type        = string
  default     = "{ ($.eventSource = config.amazonaws.com) && (($.eventName=StopConfigurationRecorder)||($.eventName=DeleteDeliveryChannel)||($.eventName=PutDeliveryChannel)||($.eventName=PutConfigurationRecorder)) }"
}

variable "security_group_changes_pattern" {
  description = "Pattern for Security Group changes"
  type        = string
  default     = "{ ($.eventName = AuthorizeSecurityGroupIngress) || ($.eventName = AuthorizeSecurityGroupEgress) || ($.eventName = RevokeSecurityGroupIngress) || ($.eventName = RevokeSecurityGroupEgress) || ($.eventName = CreateSecurityGroup) || ($.eventName = DeleteSecurityGroup)}"
}

variable "nacl_changes_pattern" {
  description = "Pattern for NACL changes"
  type        = string
  default     = "{ ($.eventName = CreateNetworkAcl) || ($.eventName = CreateNetworkAclEntry) || ($.eventName = DeleteNetworkAcl) || ($.eventName = DeleteNetworkAclEntry) || ($.eventName = ReplaceNetworkAclEntry) || ($.eventName = ReplaceNetworkAclAssociation) }"
}

variable "network_gw_changes_pattern" {
  description = "Pattern for Network GW changes"
  type        = string
  default     = "{ ($.eventName = CreateCustomerGateway) || ($.eventName = DeleteCustomerGateway) || ($.eventName = AttachInternetGateway) || ($.eventName = CreateInternetGateway) || ($.eventName = DeleteInternetGateway) || ($.eventName = DetachInternetGateway) }"
}

variable "route_table_changes_pattern" {
  description = "Pattern for Route Table changes"
  type        = string
  default     = "{ ($.eventName = CreateRoute) || ($.eventName = CreateRouteTable) || ($.eventName = ReplaceRoute) || ($.eventName = ReplaceRouteTableAssociation) || ($.eventName = DeleteRouteTable) || ($.eventName = DeleteRoute) || ($.eventName = DisassociateRouteTable) }"
}

variable "vpc_changes_pattern" {
  description = "Pattern for VPC changes"
  type        = string
  default     = "{ ($.eventName = CreateVpc) || ($.eventName = DeleteVpc) || ($.eventName = ModifyVpcAttribute) || ($.eventName = AcceptVpcPeeringConnection) || ($.eventName = CreateVpcPeeringConnection) || ($.eventName = DeleteVpcPeeringConnection) || ($.eventName = RejectVpcPeeringConnection) || ($.eventName = AttachClassicLinkVpc) || ($.eventName = DetachClassicLinkVpc) || ($.eventName = DisableVpcClassicLink) || ($.eventName = EnableVpcClassicLink) }"
}

variable "organizations_changes_pattern" {
  description = "Pattern for Organizations changes"
  type        = string
  default     = "{ ($.eventSource = organizations.amazonaws.com) && (($.eventName = \"AcceptHandshake\") || ($.eventName = \"AttachPolicy\") || ($.eventName = \"CreateAccount\") || ($.eventName = \"CreateOrganizationalUnit\") || ($.eventName= \"CreatePolicy\") || ($.eventName = \"DeclineHandshake\") || ($.eventName = \"DeleteOrganization\") || ($.eventName = \"DeleteOrganizationalUnit\") || ($.eventName = \"DeletePolicy\") || ($.eventName = \"DetachPolicy\") || ($.eventName = \"DisablePolicyType\") || ($.eventName = \"EnablePolicyType\") || ($.eventName = \"InviteAccountToOrganization\") || ($.eventName = \"LeaveOrganization\") || ($.eventName = \"MoveAccount\") || ($.eventName = \"RemoveAccountFromOrganization\") || ($.eventName = \"UpdatePolicy\") || ($.eventName =\"UpdateOrganizationalUnit\")) }"
}
