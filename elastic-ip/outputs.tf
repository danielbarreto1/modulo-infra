output "allocation_ids" {
  value = {
    for k, eip in aws_eip.eips_id : k => eip.id
  }
}