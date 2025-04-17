variable "db_username" {
  description = "The username for the production database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The password for the production database"
  type        = string
  sensitive   = true
}