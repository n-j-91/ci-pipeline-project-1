# resource "aws_security_group" "go-app-alb-sg" {
#   name        = "go-app-alb-sg"
#   description = "Allow traffic to go-app alb"
#   vpc_id      = "${data.aws_vpc.default-vpc.id}"

#   ingress {
#     description = "Allow inbound http traffic from world"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

resource "aws_security_group" "go-app-sg" {
  name        = "go-app-sg"
  description = "Allow traffic to go-app"
  vpc_id      = "${data.aws_vpc.default-vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group_rule" "allow-tcp3000-inbound-from-world" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  security_group_id = "${aws_security_group.go-app-sg.id}"
  #source_security_group_id = "${aws_security_group.go-app-alb-sg.id}"
  cidr_blocks = ["0.0.0.0/0"]
}

# resource "aws_security_group" "go-app-database-sg" {
#   name        = "go-app-database-sg"
#   description = "Allow traffic to go-app postgres db"
#   vpc_id      = "${data.aws_vpc.default-vpc.id}"

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
# resource "aws_security_group_rule" "allow-pg-inbound-from-go-app-frontend" {
#   type              = "ingress"
#   from_port         = 5432
#   to_port           = 5432
#   protocol          = "tcp"
#   security_group_id = "${aws_security_group.go-app-database-sg.id}"
#   source_security_group_id = "${aws_security_group.go-app-frontend-sg.id}"
# }