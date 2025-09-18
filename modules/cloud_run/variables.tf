variable "project_id"               {
  type = string
}
variable "region"                   {
  type = string
}
variable "service_name"             {
  type = string
}
variable "image"                    {
  type = string
}
variable "allow_unauthenticated"    {
  type = bool
}

variable "instance_connection_name" {
  type = string
}
variable "db_user"                  {
  type = string
}
variable "db_name"                  {
  type = string
}
variable "db_password"              {
  type = string
}
variable "vpc_connector_name"       {
  type = string
}
