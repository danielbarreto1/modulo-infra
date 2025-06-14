variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "internet_gateway_id" {
  type = string
}

variable "nat_gateway_id" {
  type = string
}

variable "private_route_table_names" {
  type = list(string)
}

variable "routes_rtb_private1" {
  type = list(string)
}

variable "routes_rtb_private2" {
  type = list(string)
}

variable "destination_cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags para aplicar nos recursos"
}