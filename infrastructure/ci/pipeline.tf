data "aws_kms_alias" "default-s3kmskey" {
  name = "alias/aws/s3"
}

resource "aws_codepipeline" "codepipeline-for-go-app" {
  name     = "go-app-pipeline"
  role_arn = "${aws_iam_role.codepipeline-go-app-service-role.arn}"

  artifact_store {
    location = "${aws_s3_bucket.codepipeline-bucket-for-go-app.bucket}"
    type     = "S3"

    encryption_key {
      id   = "${data.aws_kms_alias.default-s3kmskey.arn}"
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "checkout-ecr-image"
      category         = "Source"
      owner            = "AWS"
      provider         = "ECR"
      version          =  1
      output_artifacts = ["imageDetailJson"]

      configuration =  {
          RepositoryName = "${var.ecr-registry-name}"
          ImageTag = "go-app-latest"
      }
    }

    action {
      name             = "checkout-intbuildspec"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["intBuildSpec"]

      configuration = {
        Owner      = "uchann2"
        Repo       = "ci-pipeline-project-1"
        Branch     = "main"
        OAuthToken = "${var.github-personal-token}"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "convert-image-details-json"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["imageDetailJson", "intBuildSpec"]
      output_artifacts = ["imageDefinitionsJson"]
      version          = "1"

      configuration = {
        ProjectName = "${aws_codebuild_project.parse-image-details.name}"
        PrimarySource = "intBuildSpec"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "deploy-to-ecs"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      version         = 1 
      input_artifacts = ["imageDefinitionsJson"]

      configuration =  {
            ClusterName = "${var.ecs-cluster-name}"
            ServiceName = "${var.ecs-service-name}"
      }
    }
  }
}
