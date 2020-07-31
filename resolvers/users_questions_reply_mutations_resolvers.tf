resource "aws_appsync_resolver" "users_questions_reply_mutations_addQuestion_resolvers" {
  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id
  field             = "addQuestion"
  type              = "Mutation"
  data_source       = aws_appsync_datasource.test_CCC_Questions_Replies.name
  request_template  = file("mapping/Mutation/addQuestion/request.vtl")
  response_template = file("mapping/Mutation/addQuestion/response.vtl")
} 

resource "aws_appsync_resolver" "users_questions_reply_mutations_addReply_resolvers" {
  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id
  field             = "addReply"
  type              = "Mutation"
  data_source       = aws_appsync_datasource.test_CCC_Questions_Replies.name
  request_template  = file("mapping/Mutation/addReply/request.vtl")
  response_template = file("mapping/Mutation/addReply/response.vtl")
}

resource "aws_appsync_resolver" "users_questions_reply_mutations_addUser_resolvers" {
  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id
  field             = "addUser"
  type              = "Mutation"
  data_source       = aws_appsync_datasource.test_CCC_Users.name
  request_template  = file("mapping/Mutation/addUser/request.vtl")
  response_template = file("mapping/Mutation/addUser/response.vtl")
}


#resource "aws_appsync_resolver" "users_questions_reply_mutations_assignQuestion_resolvers" {
#  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id
#  field             = "assignQuestion"
#  type              = "Mutation"
#  data_source       = aws_appsync_datasource.test_CCC_Questions_Replies.name
#  request_template  = file("mapping/Mutation/assignQuestion/request.vtl")
#  response_template = file("mapping/Mutation/assignQuestion/response.vtl")
#} 


resource "aws_appsync_resolver" "users_questions_reply_mutations_assignQuestion_resolvers" {
  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id  
  field             = "assignQuestion"   
  type              = "Mutation"
  request_template  = "{}"
  response_template = "{$util.toJson($ctx.result)}"
  kind              = "PIPELINE"
  pipeline_config {
    functions = [
      "${aws_appsync_function.function_1_group_offices_for_a_users.function_id}",
      "${aws_appsync_function.function_2_Mutation_assignQuestion_Function.function_id}"
    ]
  }
}


resource "aws_appsync_function" "function_1_group_offices_for_a_users" {
  api_id                    = aws_appsync_api_key.test_CCC_supervisor.api_id
  data_source               = aws_appsync_datasource.test_CCC_Users.name
  name                      = "group_offices_for_a_users"
  request_mapping_template  = file("mapping/Mutation/assignQuestion_function_1/request_function_1.vtl")
  response_mapping_template         = file("mapping/Mutation/assignQuestion_function_1/response_function_1.vtl")

}

resource "aws_appsync_function" "function_2_Mutation_assignQuestion_Function" {
  api_id                    = aws_appsync_api_key.test_CCC_supervisor.api_id
  data_source               = aws_appsync_datasource.test_CCC_Questions_Replies.name
  name                      = "Mutation_assignQuestion_Function"
  request_mapping_template  = file("mapping/Mutation/assignQuestion_function_2/request_function_2.vtl")
  response_mapping_template = file("mapping/Mutation/assignQuestion_function_2/response_function_2.vtl")
}

resource "aws_appsync_resolver" "users_questions_reply_mutations_changeGroup_resolvers" {
  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id
  field             = "changeGroup"
  type              = "Mutation"
  data_source       = aws_appsync_datasource.test_CCC_Users.name
  request_template  = file("mapping/Mutation/changeGroup/request.vtl")
  response_template = file("mapping/Mutation/changeGroup/response.vtl")
} 

resource "aws_appsync_resolver" "users_questions_reply_mutations_changeQuestionStatus_resolvers" {
  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id
  field             = "changeQuestionStatus"
  type              = "Mutation"
  data_source       = aws_appsync_datasource.test_CCC_Questions_Replies.name
  request_template  = file("mapping/Mutation/changeQuestionStatus/request.vtl")
  response_template = file("mapping/Mutation/changeQuestionStatus/response.vtl")
} 

resource "aws_appsync_resolver" "users_questions_reply_mutations_changeRole_resolvers" {
  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id
  field             = "changeRole"
  type              = "Mutation"
  data_source       = aws_appsync_datasource.test_CCC_Users.name
  request_template  = file("mapping/Mutation/changeRole/request.vtl")
  response_template = file("mapping/Mutation/changeRole/response.vtl")
} 

resource "aws_appsync_resolver" "users_questions_reply_mutations_changeStatus_resolvers" {
  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id
  field             = "changeStatus"
  type              = "Mutation"
  data_source       = aws_appsync_datasource.test_CCC_Users.name
  request_template  = file("mapping/Mutation/changeStatus/request.vtl")
  response_template = file("mapping/Mutation/changeStatus/response.vtl")
} 

resource "aws_appsync_resolver" "users_questions_reply_mutations_resetUser_resolvers" {
  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id
  field             = "resetUser"
  type              = "Mutation"
  data_source       = aws_appsync_datasource.test_CCC_Users.name
  request_template  = file("mapping/Mutation/resetUser/request.vtl")
  response_template = file("mapping/Mutation/resetUser/response.vtl")
} 









