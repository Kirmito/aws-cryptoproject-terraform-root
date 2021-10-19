terraform {

  backend "s3" {
    region  = "us-east-1"
    encrypt = "false"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  required_version = "~> 1.0.0"
}
