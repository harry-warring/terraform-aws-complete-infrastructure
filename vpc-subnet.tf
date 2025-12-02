#Creating VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc-1"
  }
}

#Creating Public Subnet
resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.my-vpc.id
  #  map_public_ip_on_launch = true
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "public-subnet"
  }
}

#Creating Private Subnet-1
resource "aws_subnet" "private-subnet-a" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "private-subnet-a"
  }
}

#Creating Private SUbnet-2
resource "aws_subnet" "private-subnet-b" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-2b"
  tags = {
    Name = "private-subnet-b"
  }
}


#Creating Internet Gateway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-igw"
  }
}

#Creating Route Table
resource "aws_route_table" "my-rt-public-access" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
}

resource "aws_route_table_association" "public-subnet" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.my-rt-public-access.id
}
