
resource "aws_lb" "alb" {
  name               = "nikita-my-alb-deep"
  load_balancer_type = "application"
  subnets            = aws_subnet.public[*].id
  security_groups    = [aws_security_group.alb_sg.id]
}
