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

resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
  keepers = {
    project_id = var.project_id
    env        = var.env
    app_name   = var.app_name
  }
}

module "bucket" {
  source       = "./modules/bucket"
  project_id   = var.project_id
  region       = var.region
  bucket_name = "${var.app_name}-${var.project_id}-${var.env}-data-${random_string.bucket_suffix.result}"
  enable_versioning = var.enable_bucket_versioning
  depends_on   = [module.apis]
}

