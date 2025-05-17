variable "db_remote_state_key" {
  description = "Path of remote state that contains information about the database"
  type = string
  default = "stage/data-stores/mysql/terraform.tfstate"
}  

variable "db_remote_state_bucket" {
  description = "The name of S3 bucket"
  type = string
  default = "unique-name-bucket-jiow02"
}