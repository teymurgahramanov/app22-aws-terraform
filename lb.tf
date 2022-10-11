resource "aws_lb" "main" {
  name = "main"
  load_balancer_type = "application"
  security_groups = [aws_security_group.lb.id]
  subnets = aws_subnet.public.*.id
}

resource "aws_lb_target_group" "http" {
  name = "http"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id
  target_type = "ip"
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.id
  port = "80"
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.http.id
    type = "forward"
  }
}