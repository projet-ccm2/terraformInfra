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
  tier           = "db-f1-micro"
  database_version = var.db.version
  private_network = module.vpc_network.vpc_self_link
  depends_on     = [module.apis, module.vpc_network]
}

module "bucket" {
  source       = "./modules/bucket"
  project_id   = var.project_id
  region       = var.region
  bucket_name  = "${var.app_name}-${var.project_id}-data"
  depends_on   = [module.apis]
}

