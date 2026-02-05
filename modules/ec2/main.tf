resource "aws_instance" "web" {
  count = length(var.ec2_names)
  ami           = data.aws_ami.ubuntu_2204.id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = [var.sg_id]
  subnet_id = var.subnets[count.index]
  iam_instance_profile = var.iam_instance_profile_name
  availability_zone = data.aws_availability_zones.available.names[count.index]
   user_data = <<-EOF
              #!/bin/bash
              set -e
              
              sleep 120
              apt-get update -y
              sudo apt update
              sudo apt install fontconfig openjdk-21-jre -y
              java -version
              
              
              sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
                https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
              
              echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
                https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
                /etc/apt/sources.list.d/jenkins.list > /dev/null
              
              sudo apt-get update -y
              sudo apt-get install -y jenkins

              EOF

  tags = {
    Name = var.ec2_names[count.index]
  }
}