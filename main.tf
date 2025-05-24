resource "aws_vpc" "myvpc" {
        cidr_block = var.vpc_cidr_block
        tags = {
        Name = "MyVPC"
}
}

provider "aws" {
        region = var.region
}

resource "aws_subnet" "publicsubnet" {
        vpc_id = aws_vpc.myvpc.id
        cidr_block = var.publicsubnet_cidr_block

}
resource "aws_subnet" "privatesubet" {
        vpc_id = aws_vpc.myvpc.id
        cidr_block = var.privatesubnet_cidr_block
}

resource "aws_internet_gateway" "igw" {
        vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "publicRT" {
        vpc_id = aws_vpc.myvpc.id
        route {
                cidr_block = var.publicRT_cidr_block
                gateway_id = aws_internet_gateway.igw.id
}
}

resource "aws_route_table_association" "publicRTassociation" {
        subnet_id = aws_subnet.publicsubnet.id
        route_table_id = aws_route_table.publicRT.id
}

resource "aws_security_group" "security_group" {
        vpc_id = aws_vpc.myvpc.id

ingress {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
                description = "allow HTTP"
}
        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
                description = "allow SSH"

}
        egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
                description = "allow SSH"
}
}

resource "aws_instance" "ec2_instance" {
        ami = var.ami_id
        instance_type = var.type
        key_name = var.key_name
        subnet_id = aws_subnet.publicsubnet.id
        vpc_security_group_ids = [aws_security_group.security_group.id]
        associate_public_ip_address = true
}
# Test: dummy line to trigger PR
