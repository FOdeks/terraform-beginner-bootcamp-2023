variable "user_uuid" {
  description = "The UUID of the User"
  type        = string
#  validation {
#    condition     = can(regex("^\\b[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]#{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\\b$", var.user_uuid))
#    error_message = "Invalid user UUID format. It should be in the form of a UUID (e.g., 123e4567-e89b-12d3-a456-426614174000)"
#  }
}
