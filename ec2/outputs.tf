output "instance_id" {
  value = aws_instance.ec2_id.id
}

output "private_ip" {
  value = aws_instance.ec2_id.private_ip
}
