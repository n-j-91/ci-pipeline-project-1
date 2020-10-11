provider "aws" {
    region = "eu-west-1"
}

module "ecs" {
    source = "./ecs"
    ecs-task-execution-role-policy-arn = "${var.ecs-task-execution-role-policy-arn}"
    postgres-db-version = "${var.postgres-db-version}"
    postgres-db-name = "${var.postgres-db-name}"
    postgres-db-password = "${var.postgres-db-password}"
}