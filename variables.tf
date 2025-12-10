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

variable "vpc_connector_min_instances" {
  type        = number
  default     = 2
  description = "Minimum instances for VPC Access Connector (set to 0 in dev for scale-to-zero, saves ~$10-15/mois)"
}