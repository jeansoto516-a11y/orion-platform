variable "database_password" {
  description = "Senha do usuario do banco PostgreSQL"
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "Chave secreta usada para assinar tokens JWT"
  type        = string
  sensitive   = true
}

variable "network_name" {
  description = "Nome da rede Docker interna"
  type        = string
  default     = "orion-net-tf"
}

variable "api_port" {
  description = "Porta exposta da API no host"
  type        = number
  default     = 8082
}

variable "frontend_port" {
  description = "Porta exposta do frontend no host"
  type        = number
  default     = 4201
}

variable "db_port" {
  description = "Porta exposta do banco no host"
  type        = number
  default     = 5434
}