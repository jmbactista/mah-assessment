provider "aws" {
  region = var.region
}

resource "aws_eks_cluster" "my_cluster" {
  name     = var.cluster_name
  version  = var.cluster_version

  tags = {
    Environment = "Production"
  }
}

resource "aws_eks_node_group" "my_nodes" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = var.nodegroup_name
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [aws_subnet.selected.id]
  instance_types  = [var.node_type]
  desired_capacity = var.nodes
  min_size         = var.nodes_min
  max_size         = var.nodes_max

  depends_on = [aws_eks_cluster.my_cluster]
}

resource "aws_iam_role" "eks_node_role" {
  name = "${var.cluster_name}-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action    = "sts:AssumeRole"
    }]
  })
}

data "aws_subnet_ids" "selected" {
  vpc_id = aws_vpc.main.id
}

resource "aws_eks_cluster_auth" "cluster_auth" {
  name = aws_eks_cluster.my_cluster.name
}
