resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cider_block
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public_a_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.public_a_cider_block
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "terraform-public_subnet-a"
  }
}

resource "aws_subnet" "public_c_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.public_c_cider_block
  availability_zone = "ap-northeast-1c"
  tags = {
    Name = "terraform-public_subnet-c"
  }
}

resource "aws_subnet" "private_a_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_a_cider_block
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "terraform-private-subnet"
  }
}

# route setting

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "terraform-igw"
  }
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "terraform-public_rtb"
  }
}

resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "terraform-private-rtb"
  }
}

resource "aws_route_table_association" "public_a_rtb_attach" {
  subnet_id      = aws_subnet.public_a_subnet.id
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "public_c_rtb_attach" {
  subnet_id      = aws_subnet.public_c_subnet.id
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "private_a_rtb_attach" {
  subnet_id      = aws_subnet.private_a_subnet.id
  route_table_id = aws_route_table.private_rtb.id
}