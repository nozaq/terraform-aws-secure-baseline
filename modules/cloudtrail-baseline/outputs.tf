output "cloudtrail_id" {
  value = "${aws_cloudtrail.global.id}"
}

output "cloudtrail_arn" {
  value = "${aws_cloudtrail.global.arn}"
}

output "log_group_name" {
  value = "${aws_cloudwatch_log_group.cloudtrail_events.name}"
}

output "log_group_arn" {
  value = "${aws_cloudwatch_log_group.cloudtrail_events.arn}"
}
