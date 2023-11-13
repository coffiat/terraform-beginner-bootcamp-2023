
variable "terratowns_endpoint" {
  type = string
}
variable "terratowns_access_token" {
  type = string
}

variable "teacherseat_user_uuid" {
  type = string
}
variable "dragon-ball" {
  type = object({
    payday_public_path = string
    content_version    = number
  })
}

variable "payday" {
  type = object({
    payday_public_path = string
    content_version    = number
  })
}



# The regex pattern used in the validation condition checks for a standard UUID format.
