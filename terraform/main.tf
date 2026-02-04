provider "aws" {
  region = "us-east-1"
}
resource "aws_s3_bucket" "tf_s3_bucket" {
  bucket = "tf-example-bucket02"
  tags = {
    Name        = "example_bucket"
    Environment = "Dev"
  }
}
