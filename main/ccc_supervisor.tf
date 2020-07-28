

provider "aws" {
  region     = "YOUR_REGION"
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_SECRET_KEY"
}

locals {
  env = terraform.workspace
}

#######################
# AWS Appsync Api Key
#######################
resource "aws_appsync_api_key" "example_app" {
  api_id  = aws_appsync_graphql_api.example_app.id
  expires = "2021-05-02T04:00:00Z" #if you want to extend the expiring date of your api. 
}
#######################
# AWS Appsync Graphql Api
#######################
resource "aws_appsync_graphql_api" "example_app" {
  authentication_type = "API_KEY"
  name                = "example_app_${local.env}"
  schema              = file("graphql/schema.graphql")
}
