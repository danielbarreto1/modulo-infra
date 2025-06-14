variable "vpc_id" {
  type = string
}

variable "tags" {  
  type    = map(string)
  default = {}
}
variable "security_groups" {
  description = "Mapa de Security Groups a serem criados"
  type = map(object({
    description = string
    tags        = optional(map(string), {})
    ingress_rules = list(object({
      from_port                  = number
      to_port                    = number
      protocol                   = string
      cidr_blocks                = optional(list(string))
      source_security_group_name = optional(string)
      ipv6_cidr_blocks           = optional(list(string))
      prefix_list_ids            = optional(list(string))
      self                       = optional(bool)
      description                = optional(string)
    }))
    egress_rules = list(object({
      from_port                  = number
      to_port                    = number
      protocol                   = string
      cidr_blocks                = optional(list(string))
      source_security_group_name = optional(string)
      ipv6_cidr_blocks           = optional(list(string))
      prefix_list_ids            = optional(list(string))
      self                       = optional(bool)
      description                = optional(string)
    }))
  }))
}