locals {
  iam_role_name             = "${var.project}-ECSRunTaskSyncExecutionRole"
  iam_policy_name           = "FargateTaskNotificationAccessPolicy"
  iam_task_role_policy_name = "${var.project}-ECS-Task-Role-Policy"
}

resource "aws_iam_role" "role" {
  name               = local.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.policy_document.json
}
data "aws_iam_policy_document" "policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}
resource "aws_iam_role_policy" "policy" {
  name   = local.iam_policy_name
  role   = aws_iam_role.role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:GetLogEvents",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:GetRole",
                "iam:PassRole"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowPushPull",
            "Resource": [
                "${aws_ecr_repository.ecr_repo.arn}"
            ],
            "Effect": "Allow",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload"
            ]
        },
        {
            "Action": [
                "ecs:RunTask"
            ],
            "Resource": [
                "${aws_ecs_task_definition.task_definition.arn}"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "ecs:StopTask",
                "ecs:DescribeTasks"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_role" "task_execution_role" {
  name = "${var.project}-ECS-TaskExecution-Role"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}
resource "aws_iam_role" "task_role" {
  name = "${var.project}-ECS-Task-Role"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
