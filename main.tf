data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  stage_name = terraform.workspace == "default" ? var.default_env : terraform.workspace
  ecr_repo   = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${var.service_name}-${local.stage_name}"
  region     = data.aws_region.current.name
  log_group  = aws_cloudwatch_log_group.container_cloudwatch_loggroup.name
  tags = {
    project     = var.project
    environment = local.stage_name
  }
}

resource "aws_ecs_cluster" "cluster" {
  name = "${var.project}-${local.stage_name}"
  tags = merge(local.tags, { Name = "${var.project}-${local.stage_name}" })
}

resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.project}-${var.service_name}"
  task_role_arn            = aws_iam_role.task_role.arn
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  container_definitions    = <<DEFINITION
[
  {
    "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${local.log_group}",
            "awslogs-region": "${local.region}",
            "awslogs-stream-prefix": "/aws/ecs"
          }
        },
    "cpu":0,
    "dnsSearchDomains":[],
    "dnsServers":[],
    "dockerLabels":{},
    "dockerSecurityOptions":[],
    "essential":true,
    "extraHosts":[],
    "image": "${local.ecr_repo}",
    "links":[],
    "mountPoints":[],
    "name": "${var.service_name}",
    "portMappings":[
      {
        "containerPort": 80,
        "hostPort":80,
        "protocol": "tcp"
      }
    ],
    "ulimits":[],
    "volumesFrom":[],
    "environment": [
        {"name": "REGION", "value": "${local.region}"}
    ]
  }
]
DEFINITION
}

resource "aws_ecs_service" "ecs_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.cluster.id
  launch_type     = "FARGATE"
  desired_count   = var.service_desired_count
  task_definition = aws_ecs_task_definition.task_definition.arn
  network_configuration {
    security_groups = [aws_security_group.security_group.id]
    subnets         = [aws_subnet.private_subnet1.id]
  }
  tags = merge(local.tags, { Name = var.service_name })
}
