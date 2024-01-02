output "vpc-id"{
value=aws_vpc.my-vpc-1.id
}

output "subnet-id"{
value=aws_subnet.my-subnet.*.id
}
