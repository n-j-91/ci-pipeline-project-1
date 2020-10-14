provider "aws" {
    region = "eu-west-1"
}

# module "ecs" {
#     source = "./ecs"
#     ecs-task-execution-role-policy-arn = "${var.ecs-task-execution-role-policy-arn}"
#     postgres-db-version = "${var.postgres-db-version}"
#     postgres-db-name = "${var.postgres-db-name}"
#     postgres-db-password = "${var.postgres-db-password}"
#     postgres-dbhost-name = "${var.postgres-dbhost-name}"
# }

module "ci" {
    source = "./ci"
    ecr-full-access-policy-arn = "${var.ecr-full-access-policy-arn}"
    github-personal-token = "${var.github-personal-token}"
    #ecr_registry_uri = "${module.ecs.ecr_registry_uri}"
    ecr_registry_uri = "test"
}