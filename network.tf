module "vpc_network" {
  source      = "./modules/network"
  vpc_name    = "streamquest-vpc"
  subnet_name = "streamquest-subnet"
  subnet_cidr = "10.10.0.0/24"
  region      = "europe-west1"
}