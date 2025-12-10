variable "network_name" {
  type = string
}
variable "cidr_block"   {
  type = string
}
variable "vpc_connector_min" {
  type        = number
  default     = 2
  description = "Minimum instances for VPC Access Connector"
}
