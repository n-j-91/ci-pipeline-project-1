resource "aws_iam_role" "ecs-task-execution-role" {
    name = "ecs-task-execution-role"
    assume_role_policy = <<EOF
{           "Version": "2008-10-17",
            "Statement": [{  "Sid": "",
                            "Effect": "Allow",
                            "Principal": {
                                "Service": "ecs-tasks.amazonaws.com"
                            },
                        "Action": "sts:AssumeRole"
            }]  
        }
EOF
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachments" {
  role       = "${aws_iam_role.ecs-task-execution-role.name}"
  policy_arn = "${var.ecs-task-execution-role-policy-arn}"
}