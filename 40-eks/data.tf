data "aws_ssm_parameter" "database_subnet_ids" {
  name = "/${var.project}/${var.environment}/database_subnet_ids"
}
data "aws_ssm_parameter" "eks_node_sg_id" {
  name = "/${var.project}/${var.environment}/eks_node_sg_id"
}
data "aws_ssm_parameter" "eks_control_plane_sg_id" {
  name = "/${var.project}/${var.environment}/eks_control_plane_sg_id"
}