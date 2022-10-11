resource "aws_secretsmanager_secret" "db_password" {
  name = "db_password"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "db_password" {
  count = var.db_create ? 1 : 0
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = var.db_password
}