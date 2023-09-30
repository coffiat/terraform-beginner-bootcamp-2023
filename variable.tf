variable "user_uuid" {
    description = "UUID for the user"
    type        = string
validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "The user_uuid value is not a valid UUID"
}
}

# The regex pattern used in the validation condition checks for a standard UUID format.