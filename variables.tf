variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "cluster_version" {
  description = "Version of the EKS cluster."
  type        = string
}

variable "region" {
  description = "AWS region where the resources will be provisioned."
  type        = string
}

variable "nodegroup_name" {
  description = "Name of the EKS nodegroup."
  type        = string
}

variable "node_type" {
  description = "Instance type of the EKS nodes."
  type        = string
}

variable "nodes" {
  description = "Number of nodes in the EKS nodegroup."
  type        = number
}

variable "nodes_min" {
  description = "Minimum number of nodes in the EKS nodegroup."
  type        = number
}

variable "nodes_max" {
  description = "Maximum number of nodes in the EKS nodegroup."
  type        = number
}

variable "managed" {
  description = "Whether the EKS cluster is managed by AWS."
  type        = bool
}
