terraform {
  required_version = "~> 1.13"

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
  backend "s3" {
    bucket = "terraform-backendexercise"
    region = "us-east-1"
    key = "terraform.tfstate"
    use_lockfile = true
  }

}

provider "aws" {
  region = "us-east-2"
}
provider "aws" {
  region = "us-west-1"
  alias = "us-west"
}
resource "random_id" "bucket_suffix" {
  byte_length = 6
}

resource "aws_s3_bucket" "us_east_2" {
    bucket = "itsabucket2221"
}
resource "aws_s3_bucket" "us_west_1" {
    bucket = "itsabucket2445456"
    provider = aws.us-west
}



resource "aws_s3_bucket" "bucket1" { #actively managed by my terraform project
  bucket = "bucket1-${random_id.bucket_suffix.hex}"
}
output "bucket_name" {
  value = aws_s3_bucket.bucket1.bucket
}