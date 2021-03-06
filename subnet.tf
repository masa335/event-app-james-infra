resource "aws_subnet" "james_public_subnet_1a" {
  vpc_id                  = aws_vpc.james_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.r_prefix}-public-subnet-1a"
  }
}

resource "aws_subnet" "james_public_subnet_1c" {
  vpc_id                  = aws_vpc.james_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.r_prefix}-public-subnet-1c"
  }
}

resource "aws_subnet" "james_private_subnet_1a" {
  vpc_id                  = aws_vpc.james_vpc.id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.r_prefix}-private-subnet-1a"
  }
}

resource "aws_subnet" "james_private_subnet_1c" {
  vpc_id                  = aws_vpc.james_vpc.id
  cidr_block              = "10.0.11.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.r_prefix}-private-subnet-1c"
  }
}