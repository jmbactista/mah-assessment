resource "aws_iam_role" "eks_role" {
  name               = "${var.cluster_name}-eks-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_eks_cluster" "eks" {
  name    = var.cluster_name
  role_arn = aws_iam_role.eks_role.arn
}

resource "aws_iam_role_policy_attachment" "eks_vpc_cni_attachment" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

data "aws_subnet_ids" "selected" {
  vpc_id = data.aws_vpc.selected.id
}

output "eks_role_arn" {
  value = aws_iam_role.eks_role.arn
}

output "node_role_arn" {
  value = aws_iam_role.eks_role.arn
}

output "vpc_subnets" {
  value = data.aws_subnet_ids.selected.ids
}
