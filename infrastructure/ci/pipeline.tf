# data "aws_kms_alias" "default-s3kmskey" {
#   name = "alias/aws/s3"
# }

# resource "aws_codepipeline" "codepipeline-for-go-app" {
#   name     = "go-app-pipeline"
#   role_arn = "${aws_iam_role.codepipeline-go-app-service-role.arn}"

#   artifact_store {
#     location = "${aws_s3_bucket.codepipeline-bucket-for-go-app.bucket}"
#     type     = "S3"

#     encryption_key {
#       id   = "${data.aws_kms_alias.default-s3kmskey.arn}"
#       type = "KMS"
#     }
#   }

#   stage {
#     name = "Source"

#     action {
#       name             = "checkout-source"
#       category         = "Source"
#       owner            = "ThirdParty"
#       provider         = "GitHub"
#       version          = "1"
#       output_artifacts = ["source-from-github-cipipeline"]

#       configuration = {
#         Owner      = "uchann2"
#         Repo       = "ci-pipeline-project-1"
#         Branch     = "development"
#         OAuthToken = "${var.github-personal-token}"
#       }
#     }
#   }

#   stage {
#     name = "Build"

#     action {
#       name             = "Build"
#       category         = "Build"
#       owner            = "AWS"
#       provider         = "CodeBuild"
#       input_artifacts  = ["source-from-github-cipipeline"]
#       version          = "1"

#       configuration = {
#         ProjectName = "${aws_codebuild_project.go-app-build.name}"
#       }
#     }
#   }
# }
