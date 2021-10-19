data "aws_caller_identity" "this" {}

data "aws_region" "this" {}

# data "aws_iam_policy_document" "ec2_assume_role" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       identifiers = ["ec2.amazonaws.com"]
#       type        = "Service"
#     }
#   }
# }


# data "aws_iam_policy_document" "parameter_store" {
#   statement {
#     actions = [
#       "ssm:GetParametersByPath",
#       "ssm:GetParameters",
#       "ssm:GetParameter",
#     ]

#     resources = ["arn:aws:ssm:${local.aws_region}:${local.this_account_id}:parameter/${var.stack_id}/*"]
#   }
# }

# data "aws_iam_policy_document" "sqs" {
#   statement {
#     actions = [
#       "sqs:ReceiveMessage",
#       "sqs:DeleteMessage",
#       "sqs:GetQueueAttributes"
#     ]
#     resources = ["*"]
#   }
# }
