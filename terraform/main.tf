provider "aws" {
  region = "eu-south-2"
}
resource "aws_s3_bucket" "tf_s3_bucket" {
  bucket = "tf-example-bucket02"
  tags = {
    Name        = "sas_nodejs_bucket"
    Environment = "Dev"
  }
}
