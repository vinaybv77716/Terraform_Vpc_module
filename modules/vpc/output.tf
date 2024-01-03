output "vpc_id"{
value=aws_vpc.my-vpc-1.id
}

output "subnet_ids"{
value=aws_subnet.my-subnet.*.id
}
