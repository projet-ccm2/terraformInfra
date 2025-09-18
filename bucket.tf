module "projet_bucket" {
  source      = "./modules/bucket"
  project_id  = var.project_id
  region      = var.region
  bucket_name = "streamquest-bucket"
}