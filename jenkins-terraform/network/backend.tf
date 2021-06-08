terraform {
  backend "s3" {
    bucket         = "terraaform-state-file-013567"
    key            = "jenkins/network/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-lock-db"
    encrypt        = true
  }
}

