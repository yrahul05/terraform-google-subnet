provider "google" {
  project = "474608"
  region  = "asia-northeast1"
  zone    = "asia-northeast1-a"
}

#####==============================================================================
##### module-vpc
#####==============================================================================
module "vpc" {
  source                                    = "git::https://github.com/yrahul05/terraform-google-vpc.git?ref=v1.0.0"
  name                                      = "vpc"
  environment                               = "prod"
  label_order                               = ["name", "environment"]
  mtu                                       = 1460
  routing_mode                              = "REGIONAL"
  network_enabled                           = true
  network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
  delete_default_routes_on_create           = false
}
#####==============================================================================
##### module-subnetwork
#####==============================================================================
module "subnet" {
  source        = "../.."
  name          = ["test"]
  environment   = "nonprod"
  region        = "asia-northeast1"
  network       = module.vpc.vpc_id
  ip_cidr_range = ["10.10.1.0/24"]
}