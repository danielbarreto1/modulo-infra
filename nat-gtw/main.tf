resource "aws_nat_gateway" "nat_gtw_id" {
  allocation_id = var.allocation_id
  subnet_id     = var.public_subnet_id
  tags = var.tags
}
