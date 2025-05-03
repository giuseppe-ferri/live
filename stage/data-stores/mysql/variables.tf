variable "db_username" {
  description = "The username for the stage database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The password for the stage database"
  type        = string
  sensitive   = true
}