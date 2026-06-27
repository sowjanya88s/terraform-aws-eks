variable "sg_names" {
    type = list
    default = ["mongodb", "mysql" ,"redis" ,"rabbitmq", "ingress_alb" ,"bastion" ,"openvpn", "eks_control_plane", "eks_node"]
}

variable "project" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}