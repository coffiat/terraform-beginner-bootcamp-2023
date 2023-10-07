variable "user_uuid" {
type        = string
}

variable "bucket_name" {
type        = string
}

variable "index_html_filepath" {
  type        = string
}

variable "error_html_filepath" {
  type        = string
}

variable "content_version" {
  type        = number
  }

# The regex pattern used in the validation condition checks for a standard UUID format.
