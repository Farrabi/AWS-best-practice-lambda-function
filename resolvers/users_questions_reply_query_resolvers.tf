resource "aws_appsync_resolver" "users_questions_reply_queries_getUser_resolvers" {
  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id
  field             = "getUser"
  type              = "Query"
  data_source       = aws_appsync_datasource.test_CCC_Users.name
  request_template  = file("mapping/Query/getUser/request.vtl")
  response_template = file("mapping/Query/getUser/response.vtl")
}

resource "aws_appsync_resolver" "users_questions_reply_queries_getusersBygroup_resolvers" {
  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id
  field             = "getusersBygroup"
  type              = "Query"
  data_source       = aws_appsync_datasource.test_CCC_Users.name
  request_template  = file("mapping/Query/getusersBygroup/request.vtl")
  response_template = file("mapping/Query/getusersBygroup/response.vtl")
}

resource "aws_appsync_resolver" "users_questions_reply_queries_getusersByOffice_resolvers" {
  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id
  field             = "getusersByOffice"
  type              = "Query"
  data_source       = aws_appsync_datasource.test_CCC_Users.name
  request_template  = file("mapping/Query/getusersByOffice/request.vtl")
  response_template = file("mapping/Query/getusersByOffice/response.vtl")
}

resource "aws_appsync_resolver" "users_questions_reply_queries_getusersByrole_resolvers" {
  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id
  field             = "getusersByrole"
  type              = "Query"
  data_source       = aws_appsync_datasource.test_CCC_Users.name
  request_template  = file("mapping/Query/getusersByrole/request.vtl")
  response_template = file("mapping/Query/getusersByrole/response.vtl")
}

resource "aws_appsync_resolver" "users_questions_reply_queries_listQuestionsByStatus_resolvers" {
  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id
  field             = "listQuestionsByStatus"
  type              = "Query"
  data_source       = aws_appsync_datasource.test_CCC_Questions_Replies.name
  request_template  = file("mapping/Query/listQuestionsByStatus/request.vtl")
  response_template = file("mapping/Query/listQuestionsByStatus/response.vtl")
}

resource "aws_appsync_resolver" "users_questions_reply_queries_replies_resolvers" {
  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id
  field             = "reply"
  type              = "Question"
  data_source       = aws_appsync_datasource.test_CCC_Questions_Replies.name
  request_template  = file("mapping/Query/reply/request.vtl")
  response_template = file("mapping/Query/reply/response.vtl")
}


resource "aws_appsync_resolver" "users_questions_reply_queries_Question_author_resolvers" {
  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id
  field             = "author"
  type              = "Question"
  data_source       = aws_appsync_datasource.test_CCC_Users.name
  request_template  = file("mapping/Query/author/request.vtl")
  response_template = file("mapping/Query/author/response.vtl")
}


resource "aws_appsync_resolver" "users_questions_reply_queries_assignee_author_resolvers" {
  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id
  field             = "assignee"
  type              = "Question"
  data_source       = aws_appsync_datasource.test_CCC_Users.name
  request_template  = file("mapping/Query/assignee/request.vtl")
  response_template = file("mapping/Query/assignee/response.vtl")
}

resource "aws_appsync_resolver" "users_questions_reply_queries_auhtor_replies_resolvers" {
  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id
  field             = "author"
  type              = "Reply"
  data_source       = aws_appsync_datasource.test_CCC_Users.name
  request_template  = file("mapping/Query/author/request.vtl")
  response_template = file("mapping/Query/author/response.vtl")
}


resource "aws_appsync_resolver" "users_questions_reply_queries_questions_resolvers" {
  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id
  field             = "questions"
  type              = "Query"
  data_source       = aws_appsync_datasource.test_CCC_Questions_Replies.name
  request_template  = file("mapping/Query/questions/request.vtl")
  response_template = file("mapping/Query/questions/response.vtl")
}


resource "aws_appsync_resolver" "users_questions_reply_queries_users_resolvers" {
  api_id            = aws_appsync_api_key.test_CCC_supervisor.api_id
  field             = "users"
  type              = "Query"
  data_source       = aws_appsync_datasource.test_CCC_Users.name
  request_template  = file("mapping/Query/users/request.vtl")
  response_template = file("mapping/Query/users/response.vtl")
}







