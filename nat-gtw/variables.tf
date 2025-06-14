variable "allocation_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags para aplicar nos recursos"
}