resource "aws_internet_gateway" "james_igw" {
  vpc_id = aws_vpc.james_vpc.id

  tags = {
    Name = "${var.r_prefix}-igw"
  }
}