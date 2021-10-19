resource "aws_codebuild_project" "build_apply" {
  name           = "aws-cryptoproject-terraform-infra-apply-pipeline-merge"
  description    = ""
  build_timeout  = "60"
  queued_timeout = "480"

  service_role = "arn:aws:iam::846318267562:role/service-role/codebuild-aws-cryptoproject-terraform-infra-service-role"

  artifacts {
    type = "CODEPIPELINE"
    packaging              = "NONE"
    
  }

  cache {
    type = "NO_CACHE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    buildspec       = "templates/buildspec_apply.yml"
    type            = "CODEPIPELINE"
    git_clone_depth = 0
  }

}
