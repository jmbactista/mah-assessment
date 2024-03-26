provider "aws" {
  region = var.region
}

module "eks" {
  source = "./eks"

  cluster_name     = var.cluster_name
  node_group_name  = var.node_group_name
  node_type        = var.node_type
  nodes            = var.nodes
  nodes_min        = var.nodes_min
  nodes_max        = var.nodes_max
}

module "iam" {
  source = "./iam"

  cluster_name     = var.cluster_name
}
