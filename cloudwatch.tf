resource "aws_cloudwatch_log_group" "container_cloudwatch_loggroup" {
  name = "${var.project}-cloudwatch-log-group"

  tags = {
    Name        = "${var.project}-cloudwatch-log-group"
    Environment = "${local.stage_name}"
  }
}

resource "aws_cloudwatch_log_stream" "container_cloudwatch_logstream" {
  name           = "${var.project}-cloudwatch-log-stream"
  log_group_name = aws_cloudwatch_log_group.container_cloudwatch_loggroup.name
}
