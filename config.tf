locals {
  state_bucket    = var.production_account ? "global-self-service-terraform-state" : "global-self-service-dev-terraform-state"
  log_bucket_name = "self-service-logs-${var.environment}"
  name            = "selfservice-${var.environment}"
  product         = "selfservice"
  env_dns         = "${var.environment}.selfservice.global.com"
}
