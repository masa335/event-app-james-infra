resource "aws_ecs_cluster" "james_cluster" {
  name = "${var.r_prefix}-cluster"
}

resource "aws_ecs_task_definition" "james_app_nginx" {
  family                   = "james-app"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  task_role_arn            = "arn:aws:iam::${var.aws_account_id}:role/ecsTaskExecutionRole"
  execution_role_arn       = "arn:aws:iam::${var.aws_account_id}:role/ecsTaskExecutionRole"
  cpu                      = 512
  memory                   = 1024
  container_definitions    = file("./container-definitions/app-nginx.json")
}

resource "aws_ecs_service" "james_service" {
  cluster                            = aws_ecs_cluster.james_cluster.id
  launch_type                        = "FARGATE"
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  name                               = "james-service"
  task_definition                    = aws_ecs_task_definition.james_app_nginx.arn
  enable_execute_command             = true
  desired_count                      = 1

  # lifecycle {
  #  ignore_changes = [desired_count, task_definition]
  # }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.james_alb_tg.arn}"
    container_name   = "nginx"
    container_port   = 80
  }

  network_configuration {
    subnets          = [
      aws_subnet.james_private_subnet_1a.id,
      aws_subnet.james_private_subnet_1c.id
    ]
    security_groups  = [
      aws_security_group.james_sg_app.id,
      aws_security_group.james_sg_db.id
    ]
    assign_public_ip = "true"
  }
}