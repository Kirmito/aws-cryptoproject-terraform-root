# resource "aws_iam_role" "ec2_role" {
#   assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
#   name               = "${var.stack_id}-ec2-role"
# }

# resource "aws_iam_role" "ec2_role_backup" {
#   assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
#   name               = "${var.stack_id}-ec2-role-backup"
# }

# resource "aws_iam_policy" "parameter_store" {
#   name   = "${var.stack_id}-parameter-store"
#   policy = data.aws_iam_policy_document.parameter_store.json
# }

# resource "aws_iam_role_policy_attachment" "parameter_store" {
#   role       = aws_iam_role.ec2_role.name
#   policy_arn = aws_iam_policy.parameter_store.arn
# }

# resource "aws_iam_policy" "sqs" {
#   name   = "${var.stack_id}-sqs"
#   policy = data.aws_iam_policy_document.sqs.json
# }

# resource "aws_iam_role_policy_attachment" "sqs" {
#   role       = aws_iam_role.ec2_role.name
#   policy_arn = aws_iam_policy.sqs.arn
# }

