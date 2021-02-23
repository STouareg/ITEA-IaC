resource "aws_vpc" "itea-vpc" {
    cidr_block = "172.31.0.0/16"
    instance_tenancy = "default" 
    enable_dns_hostnames = true   
    tags = {
      "Name" = "itea-vpc"
    }
}

resource "aws_subnet" "itea-subnet-1" {
    vpc_id = aws_vpc.itea-vpc.id
    cidr_block = "172.31.0.0/20"
    availability_zone = "eu-central-1a"
    map_public_ip_on_launch = true
    tags = {
      "Name" = "itea-subnet-1"
    }
}
resource "aws_subnet" "itea-subnet-2" {
    vpc_id = aws_vpc.itea-vpc.id
    cidr_block = "172.31.16.0/20"
    availability_zone = "eu-central-1b"
    map_public_ip_on_launch = true
    tags = {
      "Name" = "itea-subnet-2"
    }
}

resource "aws_internet_gateway" "itea-igateway" {
    vpc_id = aws_vpc.itea-vpc.id
    tags = {
        "Name" = "itea-igateway"
    }
}

resource "aws_route_table" "itea-route-table" {
    vpc_id = aws_vpc.itea-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.itea-igateway.id
    }
}

resource "aws_route_table_association" "itea-public-subnet-1"{
    subnet_id = aws_subnet.itea-subnet-1.id
    route_table_id = aws_route_table.itea-route-table.id
}

resource "aws_security_group" "itea-ubnt-sg"{
    vpc_id = aws_vpc.itea-vpc.id

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        "Name" = "itea-ubnt-sg"
    }
}

resource "aws_security_group" "itea-db-sg"{
    vpc_id = aws_vpc.itea-vpc.id
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        "Name" = "itea-db-sg"
    }
}
