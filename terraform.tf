terraform {
  backend "s3" {
    bucket         = "global-self-service-dev-terraform-state"
    key            = "base.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.51.0"
    }
  }
}
