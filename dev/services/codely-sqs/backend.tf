terraform {
  backend "s3" {
    bucket         = "codely-tf-states"
    key            = "dev/services/codely-sqs"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "codely-tf-states"
  }
}