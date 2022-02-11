resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.project}-VPC"
  }
}

resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "${var.project}-public-subnet1"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "${var.project}-private-subnet1"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "route_table_association1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_eip" "elastic_ip" {
  vpc = true

  tags = {
    Name = "${var.project}-elastic-ip"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public_subnet1.id

  tags = {
    "Name" = "${var.project}-NATGateway"
  }
}

resource "aws_route_table" "ngw_route_table" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "ngw_route" {
  route_table_id         = aws_route_table.ngw_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.ngw.id
}

resource "aws_route_table_association" "ngw_route_table_association1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.ngw_route_table.id
}

resource "aws_security_group" "security_group" {
  name        = "${var.project}-ECSSecurityGroup"
  description = "ECS Allowed Ports"
  vpc_id      = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "security_group_rule" {
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group.id
}
