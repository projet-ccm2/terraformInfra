module "apis" {
  source     = "./modules/apis"
  project_id = var.project_id
}

module "ar" {
  source      = "./modules/artifact_registry"
  project_id  = var.project_id
  region      = var.region
  repo_id     = var.repo_id
  env         = var.env
  depends_on  = [module.apis]
}

module "db" {
  source         = "./modules/cloud_sql"
  project_id     = var.project_id
  region         = var.region
  instance_name  = var.db.instance_name
  db_name        = var.db.db_name
  db_user        = var.db.db_user
  db_password    = var.db.db_password
  tier           = var.db.tier
  database_version = var.db.version
  private_network = module.vpc_network.vpc_self_link
  enable_backups = var.enable_db_backups
  public_ip      = var.db_public_ip
  authorized_networks = var.db_authorized_networks
  activation_policy = var.db_activation_policy
  depends_on     = [module.apis, module.vpc_network]
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

module "bucket" {
  source       = "./modules/bucket"
  project_id   = var.project_id
  region       = var.region
  # Use SHA256 hash (32 chars) of project_id+env+app_name for guaranteed global uniqueness
  # This ensures the bucket name is unique across all GCP projects
  bucket_name = "${var.app_name}-${substr(sha256("${var.project_id}${var.env}${var.app_name}"), 0, 32)}"
  enable_versioning = var.enable_bucket_versioning
  depends_on   = [module.apis]
}

