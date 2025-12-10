variable "project_id" {
  type = string
}
variable "region"     {
  type = string
  default = "europe-west1"
}

variable "app_name"   {
  type = string
}          # e.g. "orders"
variable "repo_id"    {
  type = string
}          # AR repo id (one per app)

variable "image" {
  type = string
  default = ""
}

variable "allow_unauthenticated" {
  type = bool
  default = true
}

variable "db_password" {
  type = string
  default = ""
}

variable "db" {
  type = object({
    instance_name : string
    db_name       : string
    db_user       : string
    db_password   : string
    tier          : string
    version       : string
  })
}


variable "env" {
  type    = string
  default = "dev"
}

variable "enable_db_backups" {
  type        = bool
  default     = true
  description = "Enable automatic backups for Cloud SQL (disable in dev to save costs)"
}

variable "enable_bucket_versioning" {
  type        = bool
  default     = true
  description = "Enable versioning for Cloud Storage bucket (disable in dev to save costs)"
}

variable "db_public_ip" {
  type        = bool
  default     = false
  description = "Enable public IP for Cloud SQL (saves ~$10-15/month by removing VPC Connector, but less secure)"
}

variable "db_authorized_networks" {
  type        = list(string)
  default     = []
  description = "List of CIDR blocks authorized to access Cloud SQL (empty = allow all, recommended to restrict)"
}