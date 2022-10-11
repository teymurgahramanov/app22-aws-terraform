resource "aws_security_group" "lb" {
  name = "lb"
  description = "Allow inbound HTTP"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "app22" {
  name = "app22"
  description = "Allow traffic from LB to App22"  
  vpc_id = aws_vpc.main.id

  ingress {
    protocol = "tcp"
    from_port = var.app_port
    to_port = var.app_port
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db" {
  count = var.db_create ? 1 : 0
  name = "db"
  description = "Allow traffic from App22 to DB"  
  vpc_id = aws_vpc.main.id

  ingress {
    protocol = "tcp"
    from_port = "3306"
    to_port = "3306"
    security_groups = [aws_security_group.app22.id]
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}