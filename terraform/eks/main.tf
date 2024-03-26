resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = module.iam.eks_role_arn

  version = "1.21"

  vpc_config {
    subnet_ids = module.iam.vpc_subnets
  }
}

resource "aws_eks_node_group" "eks_node" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = module.iam.node_role_arn

  scaling_config {
    desired_size = var.nodes
    min_size     = var.nodes_min
    max_size     = var.nodes_max
  }

  remote_access {
    ec2_ssh_key = "your_ssh_key"  // Add your SSH key here
  }

  depends_on = [aws_eks_cluster.eks_cluster]
}
