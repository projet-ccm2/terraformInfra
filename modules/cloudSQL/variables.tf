variable "database_name" {
  type        = string
    description = "The name of the database"
}

variable "database_version" {
    type        = string
    description = "The version of the database"
}

variable "db_instance_tier" {
    type        = string
    description = "The tier of the database"
}

variable "region" {
    type        = string
    description = "The region of the database"
}

variable "db_availability_type" {
    type        = string
    description = "The availability type of the database"
}

variable "db_disk_size" {
    type        = string
    description = "The disk size of the database"
}

variable "db_disk_type" {
    type        = string
    description = "The disk type of the database"
}

variable "db_disk_autoresize" {
    type        = string
    description = "The disk autoresize of the database"
}

variable "private_network" {
    type        = string
    description = "The private network of the database"
}
