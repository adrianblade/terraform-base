resource "aws_sqs_queue" "terraform_queue" {
  name                      = "${var.stage}-codely-sqs"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  policy = aws_sqs_queue_policy.queue_policy.policy

  tags = {
    stage       = var.stage
    terraform   = "true"
    accountable = "development"
    domain      = "codely"
  }

  provider = aws.mango-test-ireland
}

resource "aws_sqs_queue_policy" "queue_policy" {
  queue_url = aws_sqs_queue.q.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "*",
      "Resource": "*",
    }
  ]
}
POLICY
}