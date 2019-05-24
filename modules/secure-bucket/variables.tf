variable "bucket_name" {
}

variable "log_bucket_name" {
}

variable "lifecycle_glacier_transition_days" {
  description = "The number of days after object creation when the object is archived into Glacier."
  default     = 90
}

