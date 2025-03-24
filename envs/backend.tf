terraform {
  backend "s3" {
    bucket  = "tf-20250401"
    key     = "tfstate/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "admin"
  }
}
