resource "aws_vpc" "lab_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "${var.project}-vpc" }
}

resource "aws_subnet" "lab_subnet" {
  vpc_id            = aws_vpc.lab_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.aws_region}a"
  tags = { Name = "${var.project}-subnet" }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.lab_vpc.id
  tags = { Name = "${var.project}-igw" }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.lab_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = { Name = "${var.project}-rt" }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.lab_subnet.id
  route_table_id = aws_route_table.rt.id
}
