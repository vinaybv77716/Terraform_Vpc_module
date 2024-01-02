#vpc
resource "aws_vpc" "my-vpc-1"{
    cidr_block=var.vpc-cidr
    tags={
        "Name"="vpc-1"
    }
}
#Subnet
resource "aws_subnet" "my-subnet"{
    vpc_id=aws_vpc.my-vpc-1.id
    map_public_ip_on_launch=true
    cidr_block=var.subnet-cidr[count.index]
    count=length(var.subnet-cidr)
      availability_zone = data.aws_availability_zones.available.names[count.index]
}

#Internet-Gateway
resource "aws_internet_gateway" "igw"{
    vpc_id=aws_vpc.my-vpc-1.id
}

#Rout-Tabel
resource "aws_route_table" "rt" {
    vpc_id=aws_vpc.my-vpc-1.id
    route{
        cidr_block="0.0.0.0/0"
        gateway_id=aws_internet_gateway.igw.id
    }
}

#Subnet-assocation
resource "aws_route_table_association" "rtas" {
subnet_id=aws_subnet.my-subnet.id
route_table_id=aws_route_table.rt.id
}
