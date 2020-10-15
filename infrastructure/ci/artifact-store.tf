resource "aws_s3_bucket" "codepipeline-bucket-for-go-app" {
  bucket = "codepipeline-bucket-for-go-app"
  acl    = "private"
}