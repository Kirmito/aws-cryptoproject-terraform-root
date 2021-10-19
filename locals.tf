locals {
  aws_region      = "us-east-1"
  this_account_id = data.aws_caller_identity.this.account_id

  stack_envs  = split("-", var.stack_id)
  stack       = local.stack_envs[0]
  layer       = local.stack_envs[1]
  environment = local.stack_envs[2]

  common_tags = {
    stack_id    = var.stack_id
    stack       = local.stack
    layer       = local.layer
    environment = local.environment
    origin      = "terraform"
    cost_center = "123456789"
  }
}
