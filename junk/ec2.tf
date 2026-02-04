resource "aws_instance" "jenkins" {
  ami                    = "ami-02b8269d5e85954ef" # Ubuntu AMI
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.profile.name

  tags = {
    Name = "nikita-Jenkins-Server-deep"
  }

  lifecycle {
    prevent_destroy = true

    ignore_changes = [
      subnet_id,
      user_data,
      key_name,
      associate_public_ip_address
    ]
  }
}