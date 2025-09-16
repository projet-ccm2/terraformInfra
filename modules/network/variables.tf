variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "subnet_name" {
  description = "cubnet name"
  type        = string
}

variable "subnet_cidr" {
  description = "subnet CIDR"
  type        = string
  default     = "10.10.0.0/24"
}

variable "region" {
  description = "vpc region"
  type        = string
}