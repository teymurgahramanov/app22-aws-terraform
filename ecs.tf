resource "aws_ecs_cluster" "main" {
  name = "main"
}

resource "aws_ecs_task_definition" "app22" {
  family = "app22"
  network_mode = "awsvpc"
  execution_role_arn = aws_iam_role.ecs_tasks_execution_role.arn
  requires_compatibilities = ["FARGATE"]
  cpu = var.ecs_task_cpu
  memory = var.ecs_task_memory
  container_definitions = var.db_create ? data.template_file.ecs_task_definition_db[0].rendered : data.template_file.ecs_task_definition.rendered
}

resource "aws_ecs_service" "app22" {
  name = "app22"
  cluster = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app22.id
  desired_count = var.ecs_task_count
  launch_type = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.app22.id]
    subnets = aws_subnet.private.*.id
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.http.id
    container_name = "app22"
    container_port = var.app_port
  }

  depends_on = [aws_lb_listener.http,aws_db_instance.app22]
}