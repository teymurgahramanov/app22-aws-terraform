resource "aws_db_instance" "app22" {
  count = var.db_create ? 1 : 0
  allocated_storage = 10
  db_name = "app22"
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.t3.micro"
  username = var.db_username
  password = var.db_password
  skip_final_snapshot  = true
  apply_immediately = true
  db_subnet_group_name = aws_db_subnet_group.app22[0].name
  vpc_security_group_ids = [aws_security_group.db[0].id]
}

resource "aws_db_subnet_group" "app22" {
  count = var.db_create ? 1 : 0
  name = "app22"
  subnet_ids = aws_subnet.private[*].id
}