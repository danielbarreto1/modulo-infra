resource "aws_internet_gateway" "igw_id" {
  vpc_id = var.vpc_id
  tags = var.tags
}