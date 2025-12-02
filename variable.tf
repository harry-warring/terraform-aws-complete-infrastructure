variable "region" {
  description = "Region for launching instance"
  type        = string
  default     = "us-east-2"
}

variable "db_password" {
  type      = string
  sensitive = true
}
