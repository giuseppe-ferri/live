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

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type = string
  default = "db.t3.micro"
}

variable "allocated_storage" {
  description = "The storage size in GiB"
  type = number
  default = 20
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type = bool
  default = false
}