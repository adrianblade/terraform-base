# resource "aws_sqs_queue" "terraform_queue" {
#   name                      = "terraform-example-queue"
#   delay_seconds             = 91
#   max_message_size          = 2048
#   message_retention_seconds = 86400
#   receive_wait_time_seconds = 10

#   tags = {
#     Environment = "production"
#   }

#   provider = aws.mango-test-ireland

# }


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
