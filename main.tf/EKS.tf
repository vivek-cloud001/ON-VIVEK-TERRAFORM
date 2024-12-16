provider "aws" {
  region = "us-west-2" # Change to your preferred region
}

# Create a VPC for EKS
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.19"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}

# Create IAM roles for EKS
module "eks_iam" {
  source  = "terraform-aws-modules/iam/aws//modules/eks"
  version = "~> 5.16"

  cluster_name = "my-eks-cluster"
}

# Create an EKS cluster
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.27" # Adjust to the desired Kubernetes version
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  cluster_iam_role_name = module.eks_iam.cluster_role_name

  node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_types = ["t3.medium"]
      key_name       = "my-key-pair" # Replace with your EC2 key pair name
    }
  }
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "kubeconfig" {
  description = "Kubeconfig for the EKS cluster"
  value       = module.eks.kubeconfig
}

output "node_group_arns" {
  description = "Node group ARNs"
  value       = module.eks.node_groups.*.arn
}
