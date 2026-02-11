terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.30.0"
    }
  }
  required_version = ">= 1.14"
}

provider "aws" {
  region = "eu-south-2"
}

resource "aws_s3_bucket" "tf_s3_bucket" {
  bucket = "tf-example-bucket02"
  tags = {
    Name        = "example_bucket"
    Environment = "Dev"
  }
}
