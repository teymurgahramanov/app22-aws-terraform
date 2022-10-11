terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  shared_config_files = [var.shared_config_files]
  shared_credentials_files = [var.shared_credentials_files]
}