output "ec2_ssm_role_name" {
  description = "Name of the IAM role for EC2 SSM access"
  value       = aws_iam_role.ec2_ssm_role.name
}

output "ec2_ssm_role_arn" {
  description = "ARN of the IAM role for EC2 SSM access"
  value       = aws_iam_role.ec2_ssm_role.arn
}

output "ec2_ssm_instance_profile_name" {
  description = "Name of the IAM instance profile attached to EC2"
  value       = aws_iam_instance_profile.ec2_ssm_profile.name
}

output "ec2_ssm_instance_profile_arn" {
  description = "ARN of the IAM instance profile attached to EC2"
  value       = aws_iam_instance_profile.ec2_ssm_profile.arn
}
