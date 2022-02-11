variable "aws_profile" {
  description = "AWS profile"
  type        = string
  default     = "fooddocs"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "fooddocs"
}

variable "default_env" {
  description = "Default environment"
  type        = string
  default     = "dev"
}

variable "service_name" {
  description = "ECS service name"
  type        = string
  default     = "php_app"
}

variable "service_desired_count" {
  description = "ECS service name"
  type        = string
  default     = "1"
}
