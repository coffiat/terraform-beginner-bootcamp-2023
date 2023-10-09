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

variable "index_html_filepath" {
  description = "Path to the index.html file"
  type        = string

}

variable "error_html_filepath" {
  description = "Path to the error.html file"
  type        = string

  validation {
    condition     = can(file(var.error_html_filepath))
    error_message = "The provided error_html_path does not point to a valid file."
  }
}

variable "content_version" {
  type        = number
  description = "Version number for content"
  
  validation {
    condition     = var.content_version > 0 && floor(var.content_version) == var.content_version
    error_message = "The content_version must be a positive integer starting at 1."
  }
}