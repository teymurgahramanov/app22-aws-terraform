data "aws_availability_zones" "available_zones" {
  state = "available"

  filter {
    name = "region-name"
    values = ["us-east-1"]
  }
}

data "template_file" "ecs_task_definition" {
  template = file("app22.json.tmpl")
  vars = {
    app_port = var.app_port
    image_tag = var.image_tag
  }
}

data "template_file" "ecs_task_definition_db" {
  count = var.db_create ? 1 : 0
  template = file("app22-db.json.tmpl")
  vars = {
    app_port = var.app_port
    image_tag = var.image_tag
    db_engine = aws_db_instance.app22[0].engine
    db_username = aws_db_instance.app22[0].username
    db_password = aws_secretsmanager_secret.db_password.arn
    db_endpoint = aws_db_instance.app22[0].endpoint
    db_name = aws_db_instance.app22[0].db_name
  }
}

data "aws_iam_policy_document" "get_secret_value" {
  statement {
    effect = "Allow"
    actions = ["secretsmanager:GetSecretValue"]
    resources = ["${aws_secretsmanager_secret.db_password.arn}"]
  }
}