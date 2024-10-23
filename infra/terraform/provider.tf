# Backend Configurations
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.4"
    }
  }
  backend "s3" {

  }
}
provider "aws" {
  region = "us-east-1"
}
