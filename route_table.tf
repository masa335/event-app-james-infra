resource "aws_route_table" "james_public_rt" {
  vpc_id = aws_vpc.james_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.james_igw.id
  }

  tags = {
    Name = "${var.r_prefix}-public-rt"
  }
}

resource "aws_route_table_association" "james_public_subnet_1a_rt_assoc" {
  subnet_id      = aws_subnet.james_public_subnet_1a.id
  route_table_id = aws_route_table.james_public_rt.id
}

resource "aws_route_table_association" "james_public_subenet_1c_rt_assoc" {
  subnet_id      = aws_subnet.james_public_subnet_1c.id
  route_table_id = aws_route_table.james_public_rt.id
}

resource "aws_route_table" "james_private_rt_1a" {
  vpc_id = aws_vpc.james_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway_1a.id
  }

  tags = {
    Name = "${var.r_prefix}-private-rt-1a"
  }
}

resource "aws_route_table" "james_private_rt_1c" {
  vpc_id = aws_vpc.james_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway_1c.id
  }

  tags = {
    Name = "${var.r_prefix}-private-rt-1c"
  }
}

resource "aws_route_table_association" "james_private_subnet_1a_rt_assoc" {
  subnet_id      = aws_subnet.james_private_subnet_1a.id
  route_table_id = aws_route_table.james_private_rt_1a.id
}

resource "aws_route_table_association" "james_private_subnet_1c_rt_assoc" {
  subnet_id      = aws_subnet.james_private_subnet_1c.id
  route_table_id = aws_route_table.james_private_rt_1c.id
}