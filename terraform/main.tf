resource "aws_vpc" "royal_hotel_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "royal-hotel-vpc"
    Environment = "dev"
    Project     = "royal-hotel"
  }
}

resource "aws_subnet" "royal_hotel_subnet" {
  vpc_id                  = aws_vpc.royal_hotel_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "royal-hotel-subnet"
    Project = "royal-hotel"
  }
}
resource "aws_internet_gateway" "royal_hotel_igw" {
  vpc_id = aws_vpc.royal_hotel_vpc.id

  tags = {
    Name    = "royal-hotel-igw"
    Project = "royal-hotel"
  }
}
resource "aws_route_table" "royal_hotel_route_table" {
  vpc_id = aws_vpc.royal_hotel_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.royal_hotel_igw.id
  }

  tags = {
    Name    = "royal-hotel-route-table"
    Project = "royal-hotel"
  }
}
resource "aws_route_table_association" "royal_hotel_subnet_association" {
  subnet_id      = aws_subnet.royal_hotel_subnet.id
  route_table_id = aws_route_table.royal_hotel_route_table.id
}
resource "aws_security_group" "royal_hotel_sg" {
  name        = "royal-hotel-developer-sg"
  description = "Security group for Royal Hotel developer VM"
  vpc_id      = aws_vpc.royal_hotel_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "royal-hotel-developer-sg"
    Project = "royal-hotel"
  }
}
resource "aws_instance" "royal_hotel_developer" {
  ami                    = "ami-0b6d9d3d33ba97d99"
  instance_type          = "t3.micro"
  key_name               = "royal-hotel-key"
  subnet_id              = aws_subnet.royal_hotel_subnet.id
  vpc_security_group_ids = [aws_security_group.royal_hotel_sg.id]

  associate_public_ip_address = true

  tags = {
    Name        = "royal-hotel-developer-vm"
    Environment = "dev"
    Project     = "royal-hotel"
    Role        = "developer"
  }
}