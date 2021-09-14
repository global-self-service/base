<!-- BEGIN_TF_DOCS -->
# Self Service base
In this repository we would maintain the aws resources created for each environment in a given AWS account

Gplan Outdoor has 4 environments in 2 AWS accounts as mentioned below
1. globalselfservicedev (435559816706)
    1. dev
    2. qa
2. globalselfserviceprod (191125840152)
    1. preprod
    2. prod

The aws resources like, VPC, subnet etc are maintained in this repository for every environment listed above.

Since we have a common backend s3 bucket for all the environment with in the AWS account we need to create terraform workspaces so that there is a distinction between envs with in the same s3 bucket.

Follow the command below to create new workspace. In the example below we have created a new workspace for "qa" environment. In case of production, make sure you are pointing to the correct backend via the backend overwrite config

```
$saml2aws login
Using IDP Account default to access ADFS https://adfs2.thisisglobal.com/adfs/ls/IdpInitiatedSignon.aspx
To use saved password just hit enter.
? Username ********@global.com
? Password ***********

Authenticating as ******@global.com ...
We've sent a text message with a verification code.
? Security Token [000000] ********
? Please choose the role Account: globalselfservicedev (435559816706) / ADFS-FullAccess
Selected role: arn:aws:iam::435559816706:role/ADFS-FullAccess
Requesting AWS credentials using SAML assertion
Logged in as: arn:aws:sts::435559816706:assumed-role/ADFS-FullAccess/******

Your new access key pair has been stored in the AWS configuration
Note that it will expire at 2020-10-08 17:42:19 +0100 BST
To use this credential, call the AWS CLI with the --profile option (e.g. aws --profile default ec2 describe-instances).

$terraform workspace new qa
Created and switched to workspace "qa"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.

# In case of production

$terraform init -reconfigure -backend-config="vars/prod.backend.tfvars"
Initializing modules...

Initializing the backend...

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

The currently selected workspace (qa) does not exist.
  This is expected behavior when the selected workspace did not have an
  existing non-empty state. Please enter a number to select a workspace:

  1. default

  Enter a value: 1

Initializing provider plugins...
- Using previously-installed hashicorp/null v2.1.2
<few more ....>

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

$terraform workspace new prod
Created and switched to workspace "prod"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.58.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.58.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_common"></a> [common](#module\_common) | github.com/global-devops-terraform/global-info | v0.49.0 |
| <a name="module_eks"></a> [eks](#module\_eks) | github.com/global-devops-terraform/eks | v0.55.3 |
| <a name="module_logs"></a> [logs](#module\_logs) | github.com/global-devops-terraform/s3 | v0.17.1 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | github.com/global-devops-terraform/vpc | v1.21.0 |

## Resources

| Name | Type |
|------|------|
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/3.58.0/docs/resources/route53_zone) | resource |
| [aws_s3_bucket_policy.logs](https://registry.terraform.io/providers/hashicorp/aws/3.58.0/docs/resources/s3_bucket_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.58.0/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/3.58.0/docs/data-sources/eks_cluster) | data source |
| [aws_iam_policy_document.s3_policy](https://registry.terraform.io/providers/hashicorp/aws/3.58.0/docs/data-sources/iam_policy_document) | data source |
| [terraform_remote_state.account](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_nlb_cidr"></a> [bastion\_nlb\_cidr](#input\_bastion\_nlb\_cidr) | n/a | `list(string)` | `[]` | no |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | CIDR block for VPC | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment | `string` | n/a | yes |
| <a name="input_es_port"></a> [es\_port](#input\_es\_port) | Elasticsearch port | `number` | `9243` | no |
| <a name="input_production_account"></a> [production\_account](#input\_production\_account) | Enabled only for production AWS account | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | Availability zones |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | Name of the logging Bucket |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Kubernetes cluster name |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | The URL on the EKS cluster OIDC Issuer |
| <a name="output_cluster_sg"></a> [cluster\_sg](#output\_cluster\_sg) | Cluster primary SG |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | External DNS domain name for each env |
| <a name="output_environment"></a> [environment](#output\_environment) | Environment |
| <a name="output_persistence_subnets"></a> [persistence\_subnets](#output\_persistence\_subnets) | Persistence subnet IDs |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | Private subnet IDs |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | Public subnet IDs |
| <a name="output_rds_subnet_group"></a> [rds\_subnet\_group](#output\_rds\_subnet\_group) | RDS subnet group |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID |
| <a name="output_worker_role"></a> [worker\_role](#output\_worker\_role) | Kubernetes worker role |
| <a name="output_worker_sg"></a> [worker\_sg](#output\_worker\_sg) | Worker SG |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | External DNS zone ID for each env |
<!-- END_TF_DOCS -->
