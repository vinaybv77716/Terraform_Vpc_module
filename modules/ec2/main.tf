resource "aws_instance" "web" {
  count = length(var.ec2_names)
  ami           = data.aws_ami.ubuntu_2204.id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = [var.sg_id]
  subnet_id = var.subnets[count.index]
  iam_instance_profile = var.iam_instance_profile_name
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = var.ec2_names[count.index]
  }
}