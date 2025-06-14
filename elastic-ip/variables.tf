variable "eips" {
  type = map(object({
    allocation_id = optional(string)
    tags          = optional(map(string), {})
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}