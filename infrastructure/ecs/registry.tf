resource "aws_ecr_repository" "dev-images" {
  name                 = "dev-images"
  image_tag_mutability = "MUTABLE"
}