resource "aws_ecs_cluster" "go-app" {
    name = "go-app"
}

output "ecs-cluster-name" {
  value = "${aws_ecs_cluster.go-app.name}"
}