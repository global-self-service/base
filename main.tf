module "eks" {
  source = "github.com/global-devops-terraform/eks?ref=v0.54.0"

  name           = local.name
  environment    = var.environment
  product        = local.product
  instance_type  = "m5.xlarge"
  asg_max        = 9
  worker_subnets = module.vpc.private_subnets
  vpc_id         = module.vpc.vpc_id

  map_roles = [
    {
      rolearn  = "arn:aws:iam::${local.account_id}:role/ADFS-FullAccess"
      username = "ADFS-FullAccess"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::${local.account_id}:role/DevopsManagement"
      username = "DevopsManagement"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::${local.account_id}:role/jenkins-devops"
      username = "jenkins-devops"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::${local.account_id}:role/DevAccess"
      username = "DevAccess"
      groups   = ["devaccess"]
    }
  ]
}
