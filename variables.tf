variable "cidr_block" {
  type        = string
  description = "CIDR block for VPC"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "es_port" {
  type        = number
  default     = 9243
  description = "Elasticsearch port"
}

variable "production_account" {
  type        = bool
  default     = false
  description = "Enabled only for production AWS account"
}
