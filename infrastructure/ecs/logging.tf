resource "aws_cloudwatch_log_group" "ecs-go-app" {
  name = "/ecs/go-app"
  retention_in_days = 1
}