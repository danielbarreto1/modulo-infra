// Private Subnets

resource "aws_subnet" "private_subnet" {
  count             = length(var.subnet_cidr_blocks_private)
  vpc_id            = var.vpc_id
  cidr_block        = element(var.subnet_cidr_blocks_private, count.index)
  availability_zone = element(var.availability_zones, count.index % length(var.availability_zones))
  tags = merge(
  {
    Name = element(var.private_subnet_names, count.index)
  },
  var.tags
)
}

// Public Subnets

resource "aws_subnet" "public_subnet" {
  count             = length(var.subnet_cidr_blocks_public)
  vpc_id            = var.vpc_id
  cidr_block        = element(var.subnet_cidr_blocks_public, count.index)
  availability_zone = element(var.availability_zones, count.index % length(var.availability_zones))
  map_public_ip_on_launch = var.mapPublicIP
  tags = merge(
  {
    Name = element(var.public_subnet_names, count.index)
  },
  var.tags
)
}

