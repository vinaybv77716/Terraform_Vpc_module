output "alb_arn" {
  value = aws_lb.alb.arn
}

output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}
