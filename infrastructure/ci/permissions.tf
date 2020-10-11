resource "aws_iam_role" "codebuild-go-app-service-role" {
    name = "codebuild-go-app-service-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "codebuild-base-policy-for-go-app" {
  name        = "CodeBuildBasePolicyForGoApp"
  path        = "/"
  description = "CodeBuild base policy for go-app project"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:eu-west-1:594776659623:log-group:/aws/codebuild/go-app-build",
                "arn:aws:logs:eu-west-1:594776659623:log-group:/aws/codebuild/go-app-build:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::codepipeline-eu-west-1-*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages"
            ],
            "Resource": [
                "arn:aws:codebuild:eu-west-1:594776659623:report-group/go-app-build-*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "codebuild-go-app-base-access" {
  role       = "${aws_iam_role.codebuild-go-app-service-role.name}"
  policy_arn = "${aws_iam_policy.codebuild-base-policy-for-go-app.arn}"
}

resource "aws_iam_role_policy_attachment" "codebuild-go-app-ecr-access" {
  role       = "${aws_iam_role.codebuild-go-app-service-role.name}"
  policy_arn = "${var.ecr-full-access-policy-arn}"
}