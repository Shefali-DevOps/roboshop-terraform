# VPC
resource "aws_vpc" "main" {
  cidr_block = var.cidr

  tags = {
    Name = "${var.env}-vpc"
  }
}

# Subnets
resource "aws_subnet" "web" {
  count = length(var.web_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.web_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "web_subnet-${split("-", var.availability_zones[count.index])[2]}"
  }
}

resource "aws_subnet" "app" {
  count = length(var.app_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.app_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "app_subnet-${split("-", var.availability_zones[count.index])[2]}"
  }
}

resource "aws_subnet" "db" {
  count = length(var.db_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.db_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "db_subnet-${split("-", var.availability_zones[count.index])[2]}"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "public_subnet-${split("-", var.availability_zones[count.index])[2]}"
  }
}

# Route Tables
resource "aws_route_table" "public" {
  count =  length(var.public_subnets)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public-rt-${split("-", var.availability_zones[count.index])[2]}"
  }
}

resource "aws_route_table" "web" {
  count =  length(var.web_subnets)
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "web-rt-${split("-", var.availability_zones[count.index])[2]}"
  }
}

resource "aws_route_table" "app" {
  count =  length(var.app_subnets)
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "app-rt-${split("-", var.availability_zones[count.index])[2]}"
  }
}

resource "aws_route_table" "db" {
  count =  length(var.db_subnets)
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "db-rt-${split("-", var.availability_zones[count.index])[2]}"
  }
}

# Route table association
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public.*.id[count.index]
  route_table_id = aws_route_table.public.*.id[count.index]
}

resource "aws_route_table_association" "app" {
  count          = length(var.app_subnets)
  subnet_id      = aws_subnet.app.*.id[count.index]
  route_table_id = aws_route_table.app.*.id[count.index]
}

resource "aws_route_table_association" "web" {
  count          = length(var.web_subnets)
  subnet_id      = aws_subnet.web.*.id[count.index]
  route_table_id = aws_route_table.web.*.id[count.index]
}

resource "aws_route_table_association" "db" {
  count          = length(var.db_subnets)
  subnet_id      = aws_subnet.db.*.id[count.index]
  route_table_id = aws_route_table.db.*.id[count.index]
}

# Internet Gateways
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}-igw"
  }
}

# NAT Gateway
resource "aws_eip" "ngw_ip" {
  count = length(var.availability_zones)
  domain = "vpc"
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.ngw_ip.*.id[count.index]
  subnet_id     = aws_subnet.public.*.id[count.index]
}

  tags = {
    Name = "nat-gw-${split("-", var.availability_zones[count.index])[2]}"
  }

