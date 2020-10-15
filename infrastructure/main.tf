provider "aws" {
    region = "eu-west-1"
}

module "ecs" {
    source = "./ecs"
    ecs-task-execution-role-policy-arn = "${var.ecs-task-execution-role-policy-arn}"
    ecr-registry-name = "${var.ecr-registry-name}"
    postgres-db-version = "${var.postgres-db-version}"
    postgres-db-name = "${var.postgres-db-name}"
    postgres-db-password = "${var.postgres-db-password}"
    postgres-dbhost-name = "${var.postgres-dbhost-name}"
}

module "ci" {
    source = "./ci"
    ecr-full-access-policy-arn = "${var.ecr-full-access-policy-arn}"
    github-personal-token = "${var.github-personal-token}"
    ecr-registry-uri = "${module.ecs.ecr-registry-uri}"
    ecr-registry-name = "${var.ecr-registry-name}"
    ecs-cluster-name = "${module.ecs.ecs-cluster-name}"
    ecs-service-name = "${module.ecs.ecs-service-name}"
}