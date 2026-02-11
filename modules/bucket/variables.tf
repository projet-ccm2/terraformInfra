variable "project_id"  {
  type = string
}
variable "region"      {
  type = string
}
variable "bucket_name" {
  type = string
}
variable "enable_versioning" {
  type        = bool
  default     = true
  description = "Enable versioning for the bucket"
}
