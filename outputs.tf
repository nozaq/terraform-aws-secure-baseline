output "audit_bucket_id" {
  value = "${module.audit_log_bucket.bucket_id}"
}

output "iam_master_role_arn" {
  value = "${module.iam_baseline.iam_master_role_arn}"
}

output "iam_manager_role_arn" {
  value = "${module.iam_baseline.iam_manager_role_arn}"
}

output "iam_support_role_arn" {
  value = "${module.iam_baseline.iam_support_role_arn}"
}
