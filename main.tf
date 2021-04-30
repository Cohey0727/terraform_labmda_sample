provider "aws" {
  #　Access keyを使っても酔いが、AWSのProfileの方が便利且つ、Secret Access Keyを間違ってGitにコミットしてしまう恐れがなく安全。
  # access_key = var.aws_access_key
  # secret_key = var.aws_secret_key

  region  = "ap-northeast-1"
  profile = "default"
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "okamoto-tf-test-bucket"
  acl    = "private"
  tags = {
    Name        = "okamoto-tf-test-bucket"
    Environment = "Dev"
  }
  versioning {
    enabled = true
  }
}

resource "aws_iam_role" "lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "archive_file" "dotfiles" {
  type        = "zip"
  output_path = "${path.module}/.temp_files/lambda.zip"
  source {
    content  = "import os"
    filename = "main.py"
  }
}

resource "aws_s3_bucket_object" "lambda_file" {
  bucket = aws_s3_bucket.test_bucket.id
  key    = "initial.zip"
  source = "${path.module}/files/lambda.zip"
}


resource "aws_lambda_function" "lambda_test" {
  function_name     = "lambda_test"
  role              = aws_iam_role.lambda.arn
  handler           = "main.handler"
  runtime           = "python3.8"
  timeout           = 120
  publish           = true
  s3_bucket         = aws_s3_bucket.test_bucket.id
  s3_key            = aws_s3_bucket_object.lambda_file.id
}

