variable "vpc_id" {
  type = string
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags para aplicar nos recursos"
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidades usadas nos recursos."
  type        = list(string)
}

// Public subnet

variable "mapPublicIP" {
  default = false
}

variable "public_subnet_names" {
  description = "Map para subrede pública."
  type        = list(string)
}

variable "subnet_cidr_blocks_public" {
  description = "Lista de CIDR blocks para as subnets públicas."
  type        = list(string)
}

// Private subnet

variable "private_subnet_names" {
  description = "Map para subrede privada."
  type        = list(string)
}

variable "subnet_cidr_blocks_private" {
  description = "Lista de CIDR blocks para as subnets privadas."
  type        = list(string)
}

