resource "aws_eks_cluster" "my_cluster" {
  name     = var.cluster_name
  version  = var.eks_version
  role_arn = aws_iam_role.my_eks_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.my_subnet.id]
  }
}

resource "aws_eks_node_group" "my_nodes" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = var.nodegroup_name
  node_role_arn   = aws_iam_role.my_node_role.arn
  subnet_ids      = [aws_subnet.my_subnet.id]
  instance_types  = [var.node_type]
  capacity_type   = "ON_DEMAND"

  scaling_config {
    min_size = var.nodes_min
    max_size = var.nodes_max
    desired_size = var.nodes
  }

  depends_on = [aws_eks_cluster.my_cluster]
}

resource "aws_iam_role" "my_eks_role" {
  name               = "my-eks-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "my_eks_policy_attachment" {
  role       = aws_iam_role.my_eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "my_node_role" {
  name               = "my-node-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "my_instance_profile" {
  name = "my-instance-profile"

  role = aws_iam_role.my_node_role.name
}

resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = var.s3_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name = "Terraform State Bucket"
  }
}

terraform {
  backend "s3" {
    bucket         = var.s3_bucket_name
    key            = "terraform-state-${formatdate("YYYY-MM-DD", timestamp())}.tfstate"
    region         = var.region
  }
}