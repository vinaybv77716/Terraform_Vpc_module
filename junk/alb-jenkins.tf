############################
# Jenkins ALB Integration #
############################

# Target Group for Jenkins
resource "aws_lb_target_group" "jenkins_tg" {
  name     = "my-jenkins-target-grp"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/login"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Attach Jenkins EC2 to Target Group
resource "aws_lb_target_group_attachment" "jenkins_attach" {
  target_group_arn = aws_lb_target_group.jenkins_tg.arn
  target_id        = aws_instance.jenkins.id
  port             = 8080
}

# ALB Listener (HTTP :80)
resource "aws_lb_listener" "jenkins_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins_tg.arn
  }
}

# Allow ALB to reach Jenkins
resource "aws_security_group_rule" "jenkins_from_alb" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
  security_group_id        = aws_security_group.jenkins_sg.id
}
