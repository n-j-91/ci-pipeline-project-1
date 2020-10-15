resource "aws_codebuild_source_credential" "github-personal-token" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = "${var.github-personal-token}"
}

resource "aws_codebuild_project" "go-app-build" {
  name          = "go-app-build"
  description   = "Build go-app code"
  build_timeout = "8"
  service_role  = "${aws_iam_role.codebuild-go-app-service-role.arn}"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode = true

    environment_variable {
      name  = "MAJOR_VERSION"
      value = "1.0.0"
    }

    environment_variable {
      name  = "ECR_REPO_PATH"
      value = "${var.ecr-registry-uri}"
    }

  }

  logs_config {
    cloudwatch_logs {
      group_name  = "${aws_cloudwatch_log_group.ci-go-app-build.name}"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/uchann2/ci-pipeline-project-1"
    git_clone_depth = 0
    buildspec = "buildspec.yml"

    auth {
      type     = "OAUTH"
      resource = "${aws_codebuild_source_credential.github-personal-token.arn}"
    }

    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = "development"
}