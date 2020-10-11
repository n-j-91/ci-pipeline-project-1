resource "aws_cloudwatch_log_group" "ci-go-app-build" {
  name = "/aws/codebuild/go-app-build"
  retention_in_days = 1
}