resource "aws_network_interface" "eni_id" {
  subnet_id       = var.subnet_id
  security_groups = [var.security_group_id]
  private_ips     = [var.private_ip]

  tags = merge(var.tags, {
    Name = "eni-${var.name}"
  })
}

resource "aws_instance" "ec2_id" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  metadata_options {
    http_tokens                 = "required"
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
  }

  network_interface {
    network_interface_id = aws_network_interface.eni_id.id
    device_index         = 0
  }

  tags = var.tags
}
