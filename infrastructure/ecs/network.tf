data "aws_vpc" "default-vpc" {
    default = true
}

data "aws_subnet_ids" "default-subnet-ids" {
  vpc_id = "${data.aws_vpc.default-vpc.id}"
}

data "aws_subnet" "default-subnets" {
  for_each = "${data.aws_subnet_ids.default-subnet-ids.ids}"
  id       = each.value
}

output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.default-subnets : s.cidr_block]
}