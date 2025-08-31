terraform {
  required_version = "~> 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

}

provider "aws" {
  region = "us-east-2"
}

resource "random_id" "bucket_suffix" {
  byte_length = 6
}

resource "aws_s3_bucket" "bucket1" { #actively managed by my terraform project
  bucket = "bucket1-${random_id.bucket_suffix.hex}"
}
output "bucket_name" {
  value = aws_s3_bucket.bucket1.bucket
}