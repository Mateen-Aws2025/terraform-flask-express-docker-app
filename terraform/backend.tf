terraform {
  backend "s3" {
    bucket         = "mateen-terraform-state-bucket"
    key            = "flask-express/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

