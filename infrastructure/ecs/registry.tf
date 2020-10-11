resource "aws_ecr_repository" "dev-images" {
  name                 = "dev-images"
  image_tag_mutability = "MUTABLE"
}

output "ecr_registry_uri" {
  value = "${aws_ecr_repository.dev-images.repository_url}"
}