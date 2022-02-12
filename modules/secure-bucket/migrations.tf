# --------------------------------------------------------------------------------------------------
# Migrations to 1.0.0
# Replacing `enabled` argument in secure-bucket module with `count` meta-argument
# --------------------------------------------------------------------------------------------------

moved {
  from = aws_s3_bucket.access_log[0]
  to   = aws_s3_bucket.access_log
}

moved {
  from = aws_s3_bucket_policy.access_log_policy[0]
  to   = aws_s3_bucket_policy.access_log_policy
}

moved {
  from = aws_s3_bucket_public_access_block.access_log[0]
  to   = aws_s3_bucket_public_access_block.access_log
}

moved {
  from = aws_s3_bucket.content[0]
  to   = aws_s3_bucket.content
}

moved {
  from = aws_s3_bucket_public_access_block.content[0]
  to   = aws_s3_bucket_public_access_block.content
}

