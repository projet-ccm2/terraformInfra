variable "network_name" {
  type = string
}
variable "cidr_block"   {
  type = string
}
variable "project_id" {
  type = string
}
variable "region" {
  type    = string
  default = "europe-west1"
}
variable "connector_cidr" {
  type        = string
  default     = "10.10.1.0/28"
  description = "CIDR pour le connecteur VPC Serverless (min /28)"
}
