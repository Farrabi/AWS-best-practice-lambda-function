################
# Provider
################
provider "aws" {
region = "YOUR_REGION" 
access_key="YOUR_ACCESS_KEY" 
secret_key="YOUR_SECRET_KEY"
}

################
# local variable
################
locals {
    env=terraform.workspace
    api_settings=yamldecode(file("${terraform.workspace}.yaml"))
}

################
# AWS S3
################
resource "aws_s3_bucket" "test_s3_bucket" {
bucket="reset-users-${local.env}"
acl="private"
}

################
# Zip File 
################
data "archive_file" "lambda_zip" {
    type        = "zip"
    source_dir  = "source"
    output_path = "resetusers.zip"
}

################
# S3 Object
################
resource "aws_s3_bucket_object" "s3_reset_users" {
depends_on=[data.archive_file.lambda_zip]
bucket="reset-users-${local.env}"
key="dependencies.zip"
source=data.archive_file.lambda_zip.output_path
}

################
# AWS Lambda
################
resource "aws_lambda_function" "reset-users-test" {
filename = data.archive_file.lambda_zip.output_path
#source_code_hash = "${data.archive_file.lambda_zip.lambda_function.py}"
role=aws_iam_role.reset-lambda-exec.arn
function_name="ResetUsers_${local.env}" 
depends_on=[aws_s3_bucket_object.s3_reset_users]
#s3_bucket="reset-users-${local.env}" 
#s3_key="dependencies.zip"
handler="lambda_function.lambda_handler" 
runtime="python3.7"
timeout=30
environment {
   variables = {
     API_ENDPOINT  = local.api_settings.apiurl
     API_KEY       = local.api_settings.apikey
        }
    }
}
#################
# CloudWatch Rule
#################
resource "aws_cloudwatch_event_rule" "every_6_am" {
  name        = "reset_db_${local.env}"
  description = "reset the DB every 9pm UTC 6am JTC"
  schedule_expression ="YOUR CRON EXPRESSION"
}

###################
# CloudWatch target
###################
resource "aws_cloudwatch_event_target" "reset_every_6_am" {
depends_on= [aws_lambda_function.reset-users-test]
rule= aws_cloudwatch_event_rule.every_6_am.name
arn= aws_lambda_function.reset-users-test.arn
}

#####################
# Resource permission
#####################
resource "aws_lambda_permission" "allow_cloudwatch_to_reset_every_6am" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.reset-users-test.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_6_am.arn
}

################
# Logs
################
resource "aws_cloudwatch_log_group" "reset_db_log_group" {
  name = "/aws/lambda/${aws_lambda_function.reset-users-test.function_name}"
}

################
# Logs stream
################
resource "aws_cloudwatch_log_stream" "reset_db_log_stream" {
  name           = "reset_db_stream_${local.env}"
  log_group_name = aws_cloudwatch_log_group.reset_db_log_group.name
}


###########################################
# IAM Role (can be made in a separate file)
###########################################
resource "aws_iam_role" "reset-lambda-exec" {
  name = "reset_lambda_role_${local.env}"
 
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

#############################################
# IAM Policy (can be made in a separate file)
#############################################
resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging_${local.env}"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": ["${aws_cloudwatch_log_stream.reset_db_log_stream.arn}"],
      "Effect": "Allow"
    }
  ]
}
EOF
}
#####################
# Policy Attachement
#####################
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.reset-lambda-exec.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}
