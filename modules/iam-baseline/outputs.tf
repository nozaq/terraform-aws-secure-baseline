output "iam_master_role_arn" {
  value = "${aws_iam_role.master.arn}"
}

output "iam_manager_role_arn" {
  value = "${aws_iam_role.manager.arn}"
}

output "iam_support_role_arn" {
  value = "${aws_iam_role.support.arn}"
}
