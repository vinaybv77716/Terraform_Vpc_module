terraform {
  backend "s3" {
    bucket         = "terraform-state-nikita-waf"
    key            = "waf/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
