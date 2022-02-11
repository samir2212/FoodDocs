resource "aws_ecr_repository" "ecr_repo" {
  name = "${var.service_name}-${local.stage_name}"

  tags = {
    Name = "${var.service_name}-${local.stage_name}"
  }
}