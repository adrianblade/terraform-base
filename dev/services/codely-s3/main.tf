resource "aws_s3_bucket" "main" {

  bucket = "my-codely-test-bucket"
  acl    = "public-read"

  tags = {
    stage       = var.stage
    terraform   = "true"
    accountable = "development"
    domain      = "codely"
  }

  provider = aws.mango-test-ireland

}