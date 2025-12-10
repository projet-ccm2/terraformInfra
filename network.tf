module "vpc_network" {
  source            = "./modules/network"
  network_name      = "streamquest-vpc-2"
  cidr_block        = "10.10.0.0/24"
  vpc_connector_min = var.vpc_connector_min_instances
}