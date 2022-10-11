resource "aws_iam_role" "ecs_tasks_execution_role" {
  name = "ecs_tasks_execution_role"
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role_policy" "ecs_tasks_execution_role" {
  name = "ecs_tasks_execution_role"
  role = aws_iam_role.ecs_tasks_execution_role.id
  policy = data.aws_iam_policy_document.get_secret_value.json
}