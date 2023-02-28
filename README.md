# Goal

## (ZeroOps | Building Startups on AWS | Deploy 10000 times/day)[https://www.linkedin.com/posts/activity-6987642170161664000-Y4l8?utm_source=share&utm_medium=member_desktop]

# HowTo

## Prerequisites

1. export below environment variables in your shell:
   - AWS_ACCESS_KEY_ID=<YOUR_IAM_AWS_ACCESS_KEY_ID>
   - AWS_SECRET_ACCESS_KEY=<YOUR_IAM_AWS_SECRET_ACCESS_KEY>

## Terraform init

```
terraform init
```

In the current situation the terraform state already exist in s3 bucket.

## Deploy FooDocs Infrastructure

```
terraform plan
terraform apply
```

## Requirements

| Name                                                                     | Version   |
| ------------------------------------------------------------------------ | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.1.4  |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | >= 3.73.0 |

## Providers

| Name                                             | Version   |
| ------------------------------------------------ | --------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | >= 3.73.0 |

## Modules

| Name                                                           | Source                                   | Version |
| -------------------------------------------------------------- | ---------------------------------------- | ------- |
| <a name="module_alb"></a> [alb](#module_alb)                   | terraform-aws-modules/alb/aws            | 6.4.0   |
| <a name="module_mysql-rds"></a> [mysql-rds](#module_mysql-rds) | terraform-aws-modules/rds/aws            | 3.5.0   |
| <a name="module_sg_alb"></a> [sg_alb](#module_sg_alb)          | terraform-aws-modules/security-group/aws | 4.7.0   |

## Resources

| Name                                                                                                                                                                                                     | Type        |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_acm_certificate.fooddocs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate)                                                                              | resource    |
| [aws_appautoscaling_policy.ecs_policy_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy)                                                            | resource    |
| [aws_appautoscaling_policy.ecs_policy_memory](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy)                                                         | resource    |
| [aws_appautoscaling_target.ecs_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target)                                                                | resource    |
| [aws_cloudwatch_log_group.container_cloudwatch_loggroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group)                                               | resource    |
| [aws_cloudwatch_log_stream.container_cloudwatch_logstream](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream)                                            | resource    |
| [aws_ecr_repository.ecr_repo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository)                                                                                | resource    |
| [aws_ecs_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster)                                                                                       | resource    |
| [aws_ecs_service.ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service)                                                                                   | resource    |
| [aws_ecs_task_definition.task_definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition)                                                               | resource    |
| [aws_eip.elastic_ip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip)                                                                                                    | resource    |
| [aws_iam_policy.pull_env_from_s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)                                                                         | resource    |
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                                                                | resource    |
| [aws_iam_role.task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                                                 | resource    |
| [aws_iam_role.task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                                                           | resource    |
| [aws_iam_role_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy)                                                                                | resource    |
| [aws_iam_role_policy_attachment.ecs-task-execution-role-policy-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)                       | resource    |
| [aws_iam_role_policy_attachment.ecs_role_s3_data_bucket_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)                           | resource    |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)                                                                                 | resource    |
| [aws_nat_gateway.ngw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway)                                                                                           | resource    |
| [aws_route.ngw_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route)                                                                                                 | resource    |
| [aws_route.public_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route)                                                                                              | resource    |
| [aws_route_table.ngw_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)                                                                               | resource    |
| [aws_route_table.route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)                                                                                   | resource    |
| [aws_route_table_association.ngw_route_table_association1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association)                                          | resource    |
| [aws_route_table_association.ngw_route_table_association2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association)                                          | resource    |
| [aws_route_table_association.route_table_association1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association)                                              | resource    |
| [aws_route_table_association.route_table_association2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association)                                              | resource    |
| [aws_s3_bucket.fooddocs-dev-env-bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                                                           | resource    |
| [aws_s3_bucket_acl.fooddocs-dev-env-bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl)                                                                   | resource    |
| [aws_s3_bucket_public_access_block.fooddocs-dev-env-bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block)                                   | resource    |
| [aws_s3_bucket_server_side_encryption_configuration.fooddocs-dev-env-bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource    |
| [aws_s3_bucket_versioning.fooddocs-dev-env-bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning)                                                     | resource    |
| [aws_security_group.mysql-rds-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                                                                            | resource    |
| [aws_security_group.security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                                                                          | resource    |
| [aws_security_group_rule.security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)                                                           | resource    |
| [aws_subnet.private_subnet1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)                                                                                         | resource    |
| [aws_subnet.private_subnet2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)                                                                                         | resource    |
| [aws_subnet.public_subnet1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)                                                                                          | resource    |
| [aws_subnet.public_subnet2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)                                                                                          | resource    |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)                                                                                                           | resource    |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)                                                                            | data source |
| [aws_iam_policy_document.policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                                                            | data source |
| [aws_iam_policy_document.s3_data_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                                                      | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region)                                                                                              | data source |
| [aws_ssm_parameter.mysql_rds_master_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter)                                                              | data source |

## Inputs

| Name                                                                                             | Description         | Type     | Default             | Required |
| ------------------------------------------------------------------------------------------------ | ------------------- | -------- | ------------------- | :------: |
| <a name="input_aws_region"></a> [aws_region](#input_aws_region)                                  | AWS region          | `string` | `"eu-central-1"`    |    no    |
| <a name="input_az-1"></a> [az-1](#input_az-1)                                                    | n/a                 | `string` | `"eu-central-1a"`   |    no    |
| <a name="input_az-2"></a> [az-2](#input_az-2)                                                    | n/a                 | `string` | `"eu-central-1b"`   |    no    |
| <a name="input_default_env"></a> [default_env](#input_default_env)                               | Default environment | `string` | `"dev"`             |    no    |
| <a name="input_env-file"></a> [env-file](#input_env-file)                                        | n/a                 | `string` | `"development.env"` |    no    |
| <a name="input_project"></a> [project](#input_project)                                           | Project name        | `string` | `"fooddocs"`        |    no    |
| <a name="input_service_desired_count"></a> [service_desired_count](#input_service_desired_count) | ECS service name    | `string` | `"1"`               |    no    |
| <a name="input_service_name"></a> [service_name](#input_service_name)                            | ECS service name    | `string` | `"php_app"`         |    no    |
| <a name="input_username"></a> [username](#input_username)                                        | n/a                 | `string` | `"admin"`           |    no    |

## Outputs

| Name                                                                                            | Description |
| ----------------------------------------------------------------------------------------------- | ----------- |
| <a name="output_db_instance_arn"></a> [db_instance_arn](#output_db_instance_arn)                | n/a         |
| <a name="output_db_instance_endpoint"></a> [db_instance_endpoint](#output_db_instance_endpoint) | n/a         |
| <a name="output_db_instance_port"></a> [db_instance_port](#output_db_instance_port)             | n/a         |
