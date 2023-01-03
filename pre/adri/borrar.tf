resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-borrar-delete"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}