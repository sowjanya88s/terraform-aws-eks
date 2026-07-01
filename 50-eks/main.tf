module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"
  name               = "${var.project}-${var.environment}"
  kubernetes_version = "1.34"

  addons = {
    coredns                = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {}
    vpc-cni                = {
      before_compute = true
    }
   # metrics-server = {}
  }

  # Optional
  endpoint_public_access = false

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = local.vpc_id
  subnet_ids               = local.private_subnet_ids
  control_plane_subnet_ids = local.private_subnet_ids
   create_node_security_group = false
   create_security_group = false
   security_group_id = local.eks_control_plane_sg_id
   node_security_group_id = local.eks_node_sg_id


  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    blue = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["c7i-flex.large", "m7i-flex.large", "t4g.small"]
      capacity_type  = "SPOT"
      # instance_types = ["t3.micro"]  # use this for free-tier
      iam_role_additional_policies = {
     amazonEBS = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
     amazonEFS = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
  }


      min_size     = 2
      max_size     = 10
      desired_size = 2
    }
  }

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}"
    }
  )
}