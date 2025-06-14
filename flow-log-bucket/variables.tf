variable "domain" {
  type        = string
  description = "Nome do domínio (ex: idqas)"
}

variable "account_id" {
  type        = string
  description = "ID da conta AWS"
}

variable "region" {
  type        = string
  description = "Região da AWS (ex: us-east-1)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags para aplicar nos recursos"
}