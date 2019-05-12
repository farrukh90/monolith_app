provider "aws" {
  region = "us-east-1"
}
terraform {
  backend "s3"{
    bucket = "monolithapp"
    region = "us-east-1"
    key = "monolith_store"
  }
}