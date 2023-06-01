terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}
module "ec2" {
  source        = "../../modules/ec2"
  ami           = var.ami
  ec2_name      = var.ec2_name
  sg_name       = var.sg_name
  instnace_type = var.instnace_type
}
