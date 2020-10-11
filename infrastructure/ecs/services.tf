resource "aws_ecs_service" "go-app-database" {
    name            = "go-app-database"
    cluster         = "${aws_ecs_cluster.go-app.id}"
    task_definition = "${aws_ecs_task_definition.postgres-db.arn}"
    desired_count   = 0
    launch_type = "FARGATE"
    force_new_deployment = true

    network_configuration {
        assign_public_ip = true
        subnets = [ for s in "${data.aws_subnet.default-subnets}" : s.id ]
        security_groups = [ "${aws_security_group.go-app-database-sg.id}" ]
    }

}

resource "aws_ecs_service" "go-app" {
    name            = "go-app"
    cluster         = "${aws_ecs_cluster.go-app.id}"
    task_definition = "${aws_ecs_task_definition.go-app.arn}"
    desired_count   = 0
    launch_type = "FARGATE"
    force_new_deployment = true

    network_configuration {
        assign_public_ip = true
        subnets = [ for s in "${data.aws_subnet.default-subnets}" : s.id ]
        security_groups = [ "${aws_security_group.go-app-frontend-sg.id}", "${aws_security_group.go-app-alb-sg.id}" ]
    }

}