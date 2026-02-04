#vpc
resource "aws_vpc" "my-vpc-1"{
    cidr_block=var.vpc-cidr
    tags={
        "Name"="myvpc"
    }
}
#   public Subnet
resource "aws_subnet" "my-subnet-public-useast1"{
    count=length(var.public_subnet_cidrs)
    vpc_id=aws_vpc.my-vpc-1.id
    map_public_ip_on_launch=true  
    cidr_block=var.public_subnet_cidrs[count.index]
    availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
    tags = merge(
        {Name = "my-subnet-public-useast1-${count.index}"},
    var.public-subnet-tags      )   

}

#   private Subnet
resource "aws_subnet" "my-subnet-private-useast1"{
    vpc_id=aws_vpc.my-vpc-1.id
    cidr_block=var.private_subnet_cidrs[count.index]
    count=length(var.private_subnet_cidrs)
    availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
    tags = merge(
        {Name = "my-subnet-private-useast1-${count.index}"},
    var.private-subnet-tags      )

}


#Internet-Gateway
resource "aws_internet_gateway" "igw-useast1"{
    vpc_id=aws_vpc.my-vpc-1.id
    tags = {
      Name="my-igw-useast1"
    }
}

#Rout-Tabel-public
resource "aws_route_table" "rt-public-useast1" {
    vpc_id=aws_vpc.my-vpc-1.id
    route{
        cidr_block="0.0.0.0/0"
        gateway_id=aws_internet_gateway.igw-useast1.id
    }
    tags = {
      Name="-my-rt-public-useast1"
    }
}

#Subnet-assocation-public
resource "aws_route_table_association" "rtas-public-useast1" {
  count = length(var.public_subnet_cidrs)
  subnet_id=aws_subnet.my-subnet-public-useast1[count.index].id
  route_table_id=aws_route_table.rt-public-useast1.id 
}

#EIP-for-NAT-Gateway
resource "aws_eip" "gw_useast1" {
  domain = "vpc"
  tags = {
    Name = "my-eip-useast1"
  }
}
#NAT-Gateway
resource "aws_nat_gateway" "gw-east" {
  subnet_id     = aws_subnet.my-subnet-public-useast1[0].id
  allocation_id = aws_eip.gw_useast1.id
  tags = {
    Name = "my-nat-gateway-useast1"
  }
  depends_on = [aws_internet_gateway.igw-useast1]
}


#Rout-Tabel-private
resource "aws_route_table" "rt-private-useast1" {
  vpc_id = aws_vpc.my-vpc-1.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw-east.id
  }

  tags = {
    Name = "my-rt-private-useast1"
  }
}


#Subnet-assocation-private
resource "aws_route_table_association" "rtas-private-useast1" {
  count = length(var.private_subnet_cidrs)
subnet_id=aws_subnet.my-subnet-private-useast1[count.index].id
route_table_id=aws_route_table.rt-private-useast1.id
}