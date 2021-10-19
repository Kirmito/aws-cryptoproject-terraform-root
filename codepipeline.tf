resource "aws_codepipeline" "pipeline_apply" {
  name     = "aws-cryptoproject-terraform-infra-apply-merge"
  role_arn = "arn:aws:iam::846318267562:role/service-role/aws-cryptoproject-terraform-infra-apply-merge"

  artifact_store {
    location = "codepipeline-us-east-1-489875770865"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      namespace        = "SourceVariables"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        ConnectionArn        = "arn:aws:codestar-connections:us-east-1:846318267562:connection/ec0f2933-6c78-4752-a8b7-3bc8638ecfbd"
        FullRepositoryId     = "Kirmito/aws-cryptoproject-terraform-infra"
        BranchName           = "develop"
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      namespace        = "BuildVariables"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildPlan"]
      version          = "1"

      configuration = {
        ProjectName = "aws-cryptoproject-terraform-infra-plan-pr"
      }
    }

    action {
      category         = "Approval"
      configuration    = {}
      input_artifacts  = []
      name             = "ManualApproval"
      output_artifacts = []
      owner            = "AWS"
      provider         = "Manual"
      region           = "us-east-1"
      run_order        = 2
      version          = "1"
    }
  }

  stage {
    name = "Apply"

    action {
      name             = "BuildApply"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact","BuildPlan"]
      output_artifacts = ["ArtifactsApply"]
      version          = "1"

      configuration = {
        "PrimarySource" = "SourceArtifact"
        "ProjectName" = "aws-cryptoproject-terraform-infra-apply-pipeline-merge"
      }
    }
  }
}
