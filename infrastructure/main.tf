terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "SmartDisco"

    workspaces {
      name = "production"
    }
  }
}

module "video_stream_analysis" {
  source     = "./modules/video_stream_analysis"
  project    = var.PROJECT
  env        = var.ENV
  region     = var.REGION
  account_id = var.ACCOUNT_ID
}