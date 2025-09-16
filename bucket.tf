module "projet_bucket" {
  source               = "./modules/bucket"
  bucket_name          = "streamquest-bucket"
  bucket_location      = "europe-west1"
  bucket_storage_class = "STANDARD"
  bucket_force_destroy = true
  bucket_level_access  = true
}