variable "project_id"    {
  type = string
}
variable "region"        {
  type = string
}
variable "instance_name" {
  type = string
}
variable "db_name"       {
  type = string
}
variable "db_user"       {
  type = string
}
variable "db_password"   {
  type = string
}
variable "tier"          {
  type = string
}

variable "database_version" {
  type = string
}
variable "private_network" {
  type = string
}
variable "enable_backups" {
  type        = bool
  default     = true
  description = "Enable automatic backups for Cloud SQL"
}

variable "public_ip" {
  type        = bool
  default     = false
  description = "Enable public IP for Cloud SQL"
}

variable "authorized_networks" {
  type        = list(string)
  default     = []
  description = "List of CIDR blocks authorized to access Cloud SQL"
}