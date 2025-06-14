variable "name" {
  description = "Nome da instância e ENI"
  type        = string
}

variable "ami" {
  description = "AMI da instância"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
}

variable "key_name" {
  description = "Chave SSH para acesso"
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet privada"
  type        = string
}

variable "security_group_id" {
  description = "ID do Security Group"
  type        = string
}

variable "private_ip" {
  description = "IP privado fixo da instância"
  type        = string
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags para aplicar nos recursos"
}
