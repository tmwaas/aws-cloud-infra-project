
resource "aws_ecr_repository" "app" {
  name = "my-aws-app"
}

resource "aws_ecs_cluster" "main" {
  name = "aws-cloud-cluster"
}

resource "aws_cloudwatch_log_group" "app" {
  name              = var.cloudwatch_log_group_name
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "app" {
  family                   = "aws-cloud-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.ecs_task_execution_arn

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "${aws_ecr_repository.app.repository_url}:latest"
      essential = true
      portMappings = [{
        containerPort = 3000
        hostPort      = 3000
      }]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.app.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "app"
        }
      }
    }
  ])
}

resource "aws_security_group" "ecs_service_sg" {
  name        = "ecs_service_sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_service" "app" {
  name            = "aws-cloud-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = var.public_subnets
    security_groups = [aws_security_group.ecs_service_sg.id]
    assign_public_ip = true
  }
}

output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}
