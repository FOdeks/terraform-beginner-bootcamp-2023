variable "user_uuid" {
  description = "The UUID of the User"
  type        = string
#  validation {
#    condition     = can(regex("^\\b[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]#{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\\b$", var.user_uuid))
#    error_message = "Invalid user UUID format. It should be in the form of a UUID (e.g., 123e4567-e89b-12d3-a456-426614174000)"
#  }
}

variable "bucket_name" {
  description = "Name for the AWS S3 bucket"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9.-]{3,63}$", var.bucket_name))
    error_message = "Invalid AWS S3 bucket name. The name must be between 3 and 63 characters long and can only contain alphanumeric characters, hyphens, and periods."
  }
}
