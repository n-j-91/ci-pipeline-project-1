provider "aws" {
    region = "eu-west-1"
}

module "ecs" {
    source = "./ecs"
    ecs-task-execution-role-policy-arn="${var.ecs-task-execution-role-policy-arn}"
}