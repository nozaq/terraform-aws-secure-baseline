variable "access_key" {}
variable "secret_key" {}

variable "audit_s3_bucket_name" {
  description = "The name of the S3 bucket to store various audit logs."
  default     = "YOUR_BUCKET_NAME_HERE"
}

variable "iam_support_role_principal_arn" {
  description = "The ARN of the IAM principal element by which the support role could be assumed."
}

variable "region" {
  description = "The AWS region in which global resources are set up."
  default     = "us-east-1"
}
