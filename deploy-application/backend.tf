terraform {
  backend "s3" {
    bucket = "project-bucket-06-57"
    region = "us-east-1"
    key = "deploy/terraform.tfstate"
  }
}