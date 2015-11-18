resource "aws_vpc" "minecraft" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags {
        Name = "minecraft vpc"
    }
}

resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.minecraft.id}"

    tags {
        Name = "minecraft igw"
    }
}

resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.minecraft.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }

    tags {
        Name = "public"
    }
}

resource "aws_subnet" "publica" {
    vpc_id = "${aws_vpc.minecraft.id}"
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true
    availability_zone = "eu-west-1a"

    tags {
        Name = "minecraft public a"
        az = "eu-west-1a"
        type = "public"
    }
}

resource "aws_route_table_association" "publica" {
    subnet_id = "${aws_subnet.publica.id}"
    route_table_id = "${aws_route_table.public.id}"
}

