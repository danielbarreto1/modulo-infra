output "security_group_id" {
  value = {
    for k, sg in aws_security_group.sg_id : k => sg.id
  }
}