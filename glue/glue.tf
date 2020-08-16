
#######################
# Glue Database Catalog
#######################
resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = "database_for_${lower(local.env)}_env"
}



#######################
# Glue Table Catalog
#######################
#resource "aws_glue_catalog_table" "aws_glue_users_table" {
#  name          = lower(aws_dynamodb_table.User_table.name)
#  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
#}

#resource "aws_glue_catalog_table" "aws_glue_questions_table" {
#  name          = lower(aws_dynamodb_table.Questions_Replies_table.name)
#  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
#}


#######################
# Glue Crawler
#######################
resource "aws_glue_crawler" "aws_crawler" {
  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
  name          = "crawler_${lower(local.env)}"
  role          = aws_iam_role.glue.arn
  schedule = "cron(00 06 * * ? *)"
  s3_target {
    path = "s3://${aws_s3_bucket.dynamodb_stream_s3_bucket.bucket}/newimage/${lower(aws_dynamodb_table.Questions_Replies_table.name)}/"
  }
  s3_target {
    path = "s3://${aws_s3_bucket.dynamodb_stream_s3_bucket.bucket}/newimage/${lower(aws_dynamodb_table.User_table.name)}/"
  }
}


########################
# IAM Role
########################

resource "aws_iam_role" "glue" {
  name = "AWSGlueServiceRole-crawler_${local.env}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
########################
# IAM Policy
########################
resource "aws_iam_role_policy" "glue_policy" {
  name = "glue_policy"
  role = aws_iam_role.glue.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
      "Resource": [
        "arn:aws:s3:::${aws_s3_bucket.dynamodb_stream_s3_bucket.bucket}/newimage/${lower(aws_dynamodb_table.Questions_Replies_table.name)}*",
        "arn:aws:s3:::${aws_s3_bucket.dynamodb_stream_s3_bucket.bucket}/newimage/${lower(aws_dynamodb_table.User_table.name)}*"
      ]
    }
  ]
}
EOF
}

########################
# Policy attachement
########################
resource "aws_iam_role_policy_attachment" "glue_service" {
    role = aws_iam_role.glue.id
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}
