resource "aws_ecs_task_definition" "postgres-db" {
  family                = "postgres-db"
  container_definitions = templatefile( "${path.module}/container-definitions/postgres-db.tmpl",
                                        { pg-db-version = "${var.postgres-db-version}",
                                          pg-db-name = "${var.postgres-db-name}",
                                          pg-db-password = "${var.postgres-db-password}"
                                        }
                            )
  requires_compatibilities  = [ "FARGATE" ]

  volume {
    name      = "pg-data"
  }

  network_mode = "awsvpc"
  task_role_arn = "${aws_iam_role.ecs-task-execution-role.arn}"
  execution_role_arn = "${aws_iam_role.ecs-task-execution-role.arn}"
  cpu = 256
  memory = 512
}

resource "aws_ecs_task_definition" "go-app" {
  family                = "go-app"
  container_definitions = templatefile( "${path.module}/container-definitions/go-app.tmpl",
                                        { pg-dbhost-name = "${var.postgres-dbhost-name}",
                                          pg-db-name = "${var.postgres-db-name}",
                                          pg-db-password = "${var.postgres-db-password}",
                                          log-group = "${aws_cloudwatch_log_group.ecs-go-app.name}"
                                        }
                            )
  requires_compatibilities  = [ "FARGATE" ]

  network_mode = "awsvpc"
  task_role_arn = "${aws_iam_role.ecs-task-execution-role.arn}"
  execution_role_arn = "${aws_iam_role.ecs-task-execution-role.arn}"
  cpu = 256
  memory = 512
}