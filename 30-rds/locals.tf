locals {
    mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
    database_subnet_ids = data.aws_ssm_parameter.database_subnet_ids.value
    common_tags = {
    Project = var.project
    Environment = var.environment
    Terraform = true
  }
}