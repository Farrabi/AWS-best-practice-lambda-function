#######################
# AWS Appsync DataSource 
#######################
resource "aws_appsync_datasource" "example_app_Users" {
  api_id           = aws_appsync_graphql_api.example_app.id
  name             = "CCC_Users_${local.env}"
  type             = "AMAZON_DYNAMODB"
  service_role_arn = aws_iam_role.example_app.arn
  dynamodb_config {
    table_name = aws_dynamodb_table.User_table.name
  }
}
#######################
# AWS Appsync DataSource 
#######################
resource "aws_appsync_datasource" "example_app_Questions_Replies" {
  api_id           = aws_appsync_graphql_api.example_app.id
  name             = "CCC_Questions_${local.env}"
  type             = "AMAZON_DYNAMODB"
  service_role_arn = aws_iam_role.example_app.arn
  dynamodb_config {
    table_name = aws_dynamodb_table.Questions_Replies_table.name
  }
}

#######################
# AWS IAM Role
#######################

resource "aws_iam_role" "example_app" {
  name = "example_app_${local.env}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "appsync.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}
#######################
# AWS Role policy
#######################
resource "aws_iam_role_policy" "example_app" {
  name = "example_app_${local.env}"
  role = aws_iam_role.example_app.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": ["${aws_dynamodb_table.User_table.arn}","${aws_dynamodb_table.Questions_Replies_table.arn}"]
    }
  ]
}
EOF
}


resource "aws_iam_role_policy" "example_app_supervisor_dynamodb_policy" {
  name = "example_app_dynamodb_policy_${local.env}"
  role = aws_iam_role.example_app.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "dynamodb:*"
        ],
        "Effect": "Allow",
        "Resource": [
            "arn:aws:dynamodb:*:*:table/*"
        ]
      }
    ]
}
EOF
}

#######################
# AWS dynamodb table
#######################

resource "aws_dynamodb_table" "User_table" {
  hash_key         = "usermail"
  name             = "Users_${local.env}"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  billing_mode     = "PAY_PER_REQUEST"

  attribute {
    name = "usermail"
    type = "S"
  }


  attribute {
    name = "usergroup"
    type = "S"
  }

  attribute {
    name = "useroffice"
    type = "S"
  }

  attribute {
    name = "userrole"
    type = "S"
  }

  attribute {
    name = "userstatus"
    type = "N"
  }

  attribute {
    name = "usermail"
    type = "S"
  }

  global_secondary_index {
    name            = "userrole-userstatus-index"
    hash_key        = "userrole"
    range_key       = "userstatus"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "useroffice-index"
    hash_key        = "useroffice"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "userrole-index"
    hash_key        = "userrole"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "userstatus-index"
    hash_key        = "userstatus"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "usergroup-index"
    hash_key        = "usergroup"
    projection_type = "ALL"
  }
}
#######################
# AWS dynmodb table
#######################
resource "aws_dynamodb_table" "Questions_Replies_table" {
  hash_key         = "pk"
  range_key        = "sk"
  name             = "Questions_${local.env}"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  billing_mode     = "PAY_PER_REQUEST"


  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  attribute {
    name = "type"
    type = "S"
  }

  ttl {
    attribute_name = "ttl"
    enabled        = true
  }


  global_secondary_index {
    name            = "pk-type-index"
    hash_key        = "pk"
    range_key       = "type"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "type-pk-index"
    hash_key        = "type"
    range_key       = "pk"
    projection_type = "ALL"
  }

}




