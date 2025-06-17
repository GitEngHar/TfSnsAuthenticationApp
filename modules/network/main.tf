resource "aws_vpc" "main" {
  cidr_block = var.vpc_cider_block
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public-a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public-a_cider_block
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "terraform-public-subnet-a"
  }
}

resource "aws_subnet" "public-c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public-c_cider_block
  availability_zone = "ap-northeast-1c"
  tags = {
    Name = "terraform-public-subnet-c"
  }
}

resource "aws_subnet" "private-a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private-a_cider_block
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "terraform-private-subnet"
  }
}

# route setting

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "terraform-igw"
  }
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "terraform-public-rtb"
  }
}

resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "terraform-private-rtb"
  }
}

resource "aws_route_table_association" "public_rtb_attach" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "public_rtb_attach-c" {
  subnet_id      = aws_subnet.public-c.id
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "private_rtb_attach" {
  subnet_id      = aws_subnet.private-a.id
  route_table_id = aws_route_table.private_rtb.id
}