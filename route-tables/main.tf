resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id
  tags   = merge(var.tags, { Name = "rtb-public" })
}

resource "aws_route" "internet_gtw_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = var.destination_cidr_block
  gateway_id             = var.internet_gateway_id
}

resource "aws_route_table_association" "subnet_public_association" {
  count          = length(var.public_subnet_ids)
  subnet_id      = element(var.public_subnet_ids, count.index)
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  for_each = toset(var.private_route_table_names)
  vpc_id   = var.vpc_id
  tags     = merge(var.tags, { Name = each.key })
}

resource "aws_route" "nat_gateway_routes" {
  for_each = aws_route_table.private_rt
  route_table_id         = each.value.id
  destination_cidr_block = var.destination_cidr_block
  nat_gateway_id         = var.nat_gateway_id
}

resource "aws_route_table_association" "private_rt_association" {
  for_each = { for idx, subnet_id in var.private_subnet_ids : idx => subnet_id }

  subnet_id      = each.value
  route_table_id = aws_route_table.private_rt[element(var.private_route_table_names, tonumber(each.key))].id
}
