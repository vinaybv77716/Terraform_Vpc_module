# output "instances" {
#   value = aws_instance.web.*.id
# }

output "instance" {
  value = aws_instance.*.id
}