terraform {
  required_providers {
    aws = {
      version = "~> 3.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  version = "~> 3.0"
  region  = var.REGION  
}