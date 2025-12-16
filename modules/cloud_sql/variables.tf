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

variable "maintenance_window_day" {
  type        = number
  default     = 7
  description = "Day of week for maintenance window (1=Monday, 7=Sunday)"
}

variable "maintenance_window_hour" {
  type        = number
  default     = 3
  description = "Hour of day for maintenance window (0-23)"
}

variable "activation_policy" {
  type        = string
  default     = "ON_DEMAND"
  description = "Activation policy: ON_DEMAND (auto start/stop, saves costs), ALWAYS (always running), or NEVER (stopped, requires manual activation). Note: ON_DEMAND only available for 1st gen instances, not MySQL 8.0"
}