resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "vpc"
    }
}

resource "aws_subnet" "subnet" {
    availability_zone = var.az
    cidr_block = var.subnet_cidr
    map_public_ip_on_launch = "true"
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "subnet"
    }
}

resource "aws_internet_gateway" "internet-gateway" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "internet-gateway"
    }
}

resource "aws_route_table" "route-table" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = var.open_cidr
        gateway_id = aws_internet_gateway.internet-gateway.id
    }
    tags = {
        Name = "route-table"
    }
}

resource "aws_route_table_association" "asscociation" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route-table.id
}

resource "aws_security_group" "es_security" {
    name = "es_security"
    vpc_id = aws_vpc.vpc.id
    ingress {
        from_port = 9200
        to_port = 9300
        protocol = "tcp"
        cidr_blocks = ["${var.open_cidr}"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.open_cidr}"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["${var.open_cidr}"]
    }
    tags = {
        Name = "es-security"
    }
}
