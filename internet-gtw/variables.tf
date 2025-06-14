variable "vpc_id" {
  type = string
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags para aplicar nos recursos"
}
