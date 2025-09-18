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

variable "services" {
  type = map(object({
    image                 = string
    allow_unauthenticated = bool
  }))
}

variable "env" {
  type    = string
  default = "dev"
}