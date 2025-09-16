variable "bucket_name" {
  type = string
  description = "Bucket FQDN name"
}

variable "bucket_location" {
  type = string
  description = "GCS location"
}

variable "bucket_force_destroy" {
  type = bool
  description = "Bucket destroy policy"
}

variable "bucket_level_access" {
  type = bool
  description = "Uniform permissions management"
}

variable "bucket_storage_class" {
  type = string
  description = "GCP storage class of bucket"
}
