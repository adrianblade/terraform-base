resource "aws_s3_bucket" "main" {

  bucket = "my-codely-test-bucket"
  acl    = "authenticated-read"

  tags = {
    stage       = var.stage
    terraform   = "false"
    accountable = "development"
    domain      = "codely"
  }

  provider = aws.mango-test-ireland

}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners   = ["099720109477"] # Canonical
  provider = aws.mango-test-ireland
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.large"

  tags = {
    Name = "HelloWorld"
  }
  provider = aws.mango-test-ireland
}