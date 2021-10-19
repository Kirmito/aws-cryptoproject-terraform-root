resource "aws_codebuild_project" "build_plan_pr" {
  name           = "aws-cryptoproject-terraform-infra-plan-pr"
  description    = ""
  build_timeout  = "60"
  queued_timeout = "480"

  service_role = "arn:aws:iam::846318267562:role/service-role/codebuild-aws-cryptoproject-terraform-infra-service-role"

  artifacts {
    type = "NO_ARTIFACTS"
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
    buildspec       = "templates/buildspec_plan.yml"
    type            = "GITHUB"
    location        = "https://github.com/Kirmito/aws-cryptoproject-terraform-infra.git"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = false
    }
  }

}

resource "aws_codebuild_webhook" "build_plan_pr_webhook" {
  project_name = aws_codebuild_project.build_plan_pr.name
  build_type   = "BUILD"

  filter_group {
    filter {
      exclude_matched_pattern = false
      pattern                 = "PULL_REQUEST_CREATED, PULL_REQUEST_UPDATED, PULL_REQUEST_MERGED, PULL_REQUEST_REOPENED"
      type                    = "EVENT"
    }
    filter {
      exclude_matched_pattern = false
      pattern                 = "^refs/heads/develop$"
      type                    = "BASE_REF"
    }
  }
}
