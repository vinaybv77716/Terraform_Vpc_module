output "vpc_id"{
value=aws_vpc.my-vpc-1.id
}

output "public_subnet_ids" {
  value = aws_subnet.my-subnet-public-useast1[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.my-subnet-private-useast1[*].id
}

