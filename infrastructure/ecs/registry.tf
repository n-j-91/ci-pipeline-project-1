resource "aws_ecr_repository" "dev-images" {
  name                 = "${var.ecr-registry-name}"
  image_tag_mutability = "MUTABLE"
}

output "ecr-registry-uri" {
  value = "${aws_ecr_repository.dev-images.repository_url}"
}