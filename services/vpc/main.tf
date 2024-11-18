resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.prefix_name} VPC"
  }
}

resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnets_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.public_subnets_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.prefix_name} Public Subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnets_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.private_subnets_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.prefix_name} Private Subnet ${count.index + 1}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.prefix_name} VPC IG"
  }
}

resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.prefix_name} Public Route Table"
  }
}

resource "aws_route_table_association" "public_subnet_asso" {
  count          = length(var.public_subnets_cidrs)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.prefix_name} Private Route Table"
  }
}

resource "aws_route_table_association" "private_subnet_asso" {
  count          = length(var.private_subnets_cidrs)
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? 1 : 0

  tags = {
    Name = "${var.prefix_name} NAT EIP"
  }
}

resource "aws_nat_gateway" "nat" {
  count         = var.enable_nat_gateway ? 1 : 0
  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name = "${var.prefix_name} NAT Gateway"
  }
}

resource "aws_route" "private_nat_route" {
  count                  = var.enable_nat_gateway ? 1 : 0
  route_table_id         = aws_route_table.rt_private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat[0].id
}
