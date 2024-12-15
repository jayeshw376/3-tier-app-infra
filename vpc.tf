
#  creating vpc 
resource "aws_vpc" "three-tier" {
  cidr_block           = var.aws_vpc
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}


# public subnet 1(2a)
resource "aws_subnet" "pub1" {
  vpc_id                  = aws_vpc.three-tier.id
  cidr_block              = "172.20.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true # for auto asign public ip for subnet
  tags = {
    Name = "pub-1a"
  }
  depends_on = [aws_vpc.three-tier]
}

# public subnet 2(2b)
resource "aws_subnet" "pub2" {
  vpc_id                  = aws_vpc.three-tier.id
  cidr_block              = "172.20.2.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true # for auto asign public ip for subnet
  tags = {
    Name = "pub-2b"
  }
  depends_on = [aws_vpc.three-tier]
}


# private subnet 3(2a)
resource "aws_subnet" "prvt3" {
  vpc_id            = aws_vpc.three-tier.id
  cidr_block        = "172.20.3.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name = "prvt-3a"
  }
  depends_on = [aws_vpc.three-tier]

}

# private subnet 4(2b)
resource "aws_subnet" "prvt4" {
  vpc_id            = aws_vpc.three-tier.id
  cidr_block        = "172.20.4.0/24"
  availability_zone = "us-west-2b"
  tags = {
    Name = "prvt-4b"
  }
  depends_on = [aws_vpc.three-tier]
}

# private subnet 5(2a)
resource "aws_subnet" "prvt5" {
  vpc_id            = aws_vpc.three-tier.id
  cidr_block        = "172.20.5.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name = "prvt-5a"
  }
  depends_on = [var.aws_vpc]
}

# private subnet 6(2b)
resource "aws_subnet" "prvt6" {
  vpc_id            = aws_vpc.three-tier.id
  cidr_block        = "172.20.6.0/24"
  availability_zone = "us-west-2b"
  tags = {
    Name = "prvt-6b"
  }
  depends_on = [var.aws_vpc]
}

# private subnet 7(2a)
resource "aws_subnet" "prvt7" {
  vpc_id            = aws_vpc.three-tier.id
  cidr_block        = "172.20.7.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name = "prvt-7a"
  }
  depends_on = [var.aws_vpc]
}

# private subnet 8(2b)
resource "aws_subnet" "prvt8" {
  vpc_id            = aws_vpc.three-tier.id
  cidr_block        = "172.20.8.0/24"
  availability_zone = "us-west-2b"
  tags = {
    Name = "prvt-8b"
  }
  depends_on = [var.aws_vpc]
}

#  creating internet gateway
resource "aws_internet_gateway" "three-tier-ig" {
  vpc_id = aws_vpc.three-tier.id
  tags = {
    Name = "3-tier-ig"
  }
}


#  creating public route table
resource "aws_route_table" "three-tier-pub-rt" {
  vpc_id = aws_vpc.three-tier.id
  tags = {
    Name = "3-tier-pub-rt"
  }
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.three-tier-ig.id
  }
  depends_on = [aws_vpc.three-tier]
}



#  attaching pub-1a subnet to public route table
resource "aws_route_table_association" "public-1a" {
  subnet_id      = aws_subnet.pub1.id
  route_table_id = aws_route_table.three-tier-pub-rt.id
  depends_on     = [aws_route_table.three-tier-pub-rt]
}



#  attaching pub-2b subnet to public route table
resource "aws_route_table_association" "public-2b" {
  subnet_id      = aws_subnet.pub2.id
  route_table_id = aws_route_table.three-tier-pub-rt.id
  depends_on     = [aws_route_table.three-tier-pub-rt]
}

#  creating elastic ip for nat gateway
resource "aws_eip" "eip" {
#   vpc        = true
  depends_on = [aws_internet_gateway.three-tier-ig]
}


#  creating nat gateway
resource "aws_nat_gateway" "cust-nat" {
  allocation_id     = aws_eip.eip.id
  subnet_id         = aws_subnet.pub1.id
  connectivity_type = "public"
  tags = {
    Name = "3-tier-nat"
  }
  depends_on = [aws_eip.eip]
}

#  creating private route table 
resource "aws_route_table" "three-tier-prvt-rt" {
  vpc_id = aws_vpc.three-tier.id
  tags = {
    Name = "3-tier-privt-rt"
  }
  route  {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.cust-nat.id
  }
  depends_on = [aws_vpc.three-tier]
}


#  attaching prvt-3a subnet to private route table
resource "aws_route_table_association" "privat-3a" {
  subnet_id      = aws_subnet.prvt3.id
  route_table_id = aws_route_table.three-tier-prvt-rt.id
  depends_on     = [aws_route_table.three-tier-prvt-rt]
}


#  attaching prvt-4b subnet to private route table
resource "aws_route_table_association" "privat-4b" {
  subnet_id      = aws_subnet.prvt4.id
  route_table_id = aws_route_table.three-tier-prvt-rt.id
}


#  attaching prvt-5a subnet to private route table
resource "aws_route_table_association" "privat-5a" {
  subnet_id      = aws_subnet.prvt5.id
  route_table_id = aws_route_table.three-tier-prvt-rt.id
}


#  attaching prvt-6b subnet to private route table
resource "aws_route_table_association" "privat-6b" {
  subnet_id      = aws_subnet.prvt6.id
  route_table_id = aws_route_table.three-tier-prvt-rt.id

}


#  attaching prvt-7a subnet to private route table
resource "aws_route_table_association" "privat-7a" {
  subnet_id      = aws_subnet.prvt7.id
  route_table_id = aws_route_table.three-tier-prvt-rt.id
}

#  attaching prvt-8b subnet to private route table
resource "aws_route_table_association" "privat-8b" {
  subnet_id      = aws_subnet.prvt8.id
  route_table_id = aws_route_table.three-tier-prvt-rt.id
}

