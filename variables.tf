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

variable "username" {
  type    = string
  default = "admin"
}

variable "az-1" {
  type    = string
  default = "eu-central-1a"
}

variable "az-2" {
  type    = string
  default = "eu-central-1b"
}

variable "env-file" {
  type    = string
  default = "development.env"
}
