resource "aws_ecr_repository" "repo" {
  name = "nodejs-app"
}

resource "aws_ecs_cluster" "cluster" {
  name = "nodejs-ci-cd-cluster"
}

resource "aws_ecs_task_definition" "task" {
  family                   = "nodejs-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "nodejs-app"
      image     = "${var.ecr_repo_uri}:latest"
      essential = true
      portMappings = [{
        containerPort = 3000
        hostPort      = 3000
      }]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/nodejs-app"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "service" {
  name            = "nodejs-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = [var.subnet_id]
    security_groups  = [var.sg_id]
    assign_public_ip = true
  }
}
