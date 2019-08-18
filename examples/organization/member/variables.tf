variable "access_key" {
}

variable "secret_key" {
}

variable "audit_s3_bucket_name" {
  description = "The name of the S3 bucket to store various audit logs."
}

variable "region" {
  description = "The AWS region in which global resources are set up."
  default     = "us-east-1"
}

variable "master_account_id" {
  description = "The ID of the master AWS account."
}
