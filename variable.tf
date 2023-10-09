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

  variable "assets_path" {
  description = "Path to asstes folder"
  string
  
}

# The regex pattern used in the validation condition checks for a standard UUID format.
