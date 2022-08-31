resource "aws_s3_bucket" "main" {

  bucket = "my-codely-test-bucket"
  acl    = "public-read"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    stage       = var.stage
    terraform   = "false"
    accountable = "development"
    domain      = "codely"
  }

  provider = aws.mango-test-ireland

}

resource "aws_s3_bucket" "main2" {

  bucket = "my-codely-test-bucket2"
  acl    = "public-read"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    stage       = var.stage
    terraform   = "false"
    accountable = "development"
    domain      = "codely"
  }

  provider = aws.mango-test-ireland

}

resource "aws_sqs_queue" "terraform_queue" {
  name                      = "terraform-codely-example-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  tags = {
    Environment = "production"
  }
  provider = aws.mango-test-ireland
}