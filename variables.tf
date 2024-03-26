variable "region" {
  default     = "ap-southeast-1"
}

variable "cluster_name" {
  description = "EKS cluster"
  default     = "assessemnt-eks-cluster"
}

variable "node_group_name" {
  description = "EKS node group"
  default     = "my-nodes"
}

variable "node_type" {
  default     = "t2.micro"
}

variable "nodes" {
  description = "Number of nodes in the EKS node group"
  default     = 2
}

variable "nodes_min" {
  description = "Minimum count of nodes"
  default     = 1
}

variable "nodes_max" {
  description = "Maximum count of nodes"
  default     = 2
}
