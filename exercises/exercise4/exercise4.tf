terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_s3_bucket" "my_bucket" { #actively managed by my terraform project
  bucket = var.bucket_name # taken from below variable "bucket_name"
}

data "aws_s3_bucket" "my_external_bucket" { #managed somewhere else, 
  bucket = "not-managed-by-us"              #just want to use for our project
}

variable "bucket_name" {
    type = string
    description = "my var used to set bucket name"
    default = "my_default_bucket_name"
}

output "bucket_id" {
    value = aws_s3_bucket.my_bucket.id
}

locals { #temporary variables to help us write code / store info during func execution
    local_example = "This is a local variable"
}

module "my_module" {
    source = "./module-example"
}