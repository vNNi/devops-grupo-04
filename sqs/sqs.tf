resource "aws_sqs_queue" "sqs_book_queue_dead_letter" {
  name  = "sqs_book_queue_dead_letter"
}

resource "aws_sqs_queue" "sqs_book_queue" {
  name                      = "sqs_book_queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.sqs_book_queue_dead_letter.arn
    maxReceiveCount     = 4
  })

  tags = {
    Environment = "production"
  }
}