output "cluster_name" {
  value = aws_eks_cluster.my_cluster.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.my_cluster.endpoint
}

output "cluster_certificate_authority" {
  value = aws_eks_cluster.my_cluster.certificate_authority[0].data
}

output "cluster_security_group_ids" {
  value = aws_eks_cluster.my_cluster.vpc_config[0].security_group_ids
}
