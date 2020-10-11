variable "ecs-task-execution-role-policy-arn" {
    type = string
    description = "AWS ECS task exection role policy arn"
    default = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

variable "ecr-full-access-policy-arn" {
    type = string
    description = "AWS ECR full access policy arn"
    default = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

variable "postgres-db-version" {
    type = string
    description = "Postgres database image version"
    default = "9.6"
}

variable "postgres-db-name" {
    type = string
    description = "Postgres database name"
    default = "app"
}

variable "postgres-db-password" {
    type = string
    description = "Postgres database password"
    default = "pg@dm!n123"
}

variable "postgres-dbhost-name" {
    type = string
    description = "Postgres database host / ip"
    default = "172.31.23.161"
}