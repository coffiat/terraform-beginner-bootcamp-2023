variable "user_uuid" {
        description = "The UUID for the user"
        type        = string
        validation {
            condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
            error_message = "The user_uuid value is not a valid UUID"
        }
}


variable "bucket_name" {
        description = "The Name of the S3 bucket"
    type        = string

    validation {
    condition     = can(regex("^[a-zA-Z0-9.-]+$", var.bucket_name)) && length(var.bucket_name) <= 63
    error_message = "Invalid bucket name. Bucket names must be between 3 and 63 characters in length and can contain only lowercase letters, numbers, hyphens, and dots. They must start and end with a lowercase letter or number."
  }
}