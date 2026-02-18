module "vpc_network" {
  source       = "./modules/network"
  project_id   = var.project_id
  region       = var.region
  network_name = "streamquest-vpc-2"
  cidr_block   = "10.10.0.0/24"
  depends_on   = [module.apis]
}