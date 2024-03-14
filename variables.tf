variable "postgres_database_name" {
  description = "Nome do banco de dados"
  type        = string
}

variable "postgres_database_username" {
  description = "Nome de usuário do banco de dados"
  type        = string
}

variable "postgres_database_password" {
  description = "Senha do usuário do banco de dados"
  type        = string
}

variable "postgres_database_instance_class" {
  description = "Classe da instância do banco de dados"
  type        = string
}

variable "postgres_database_engine_version" {
  description = "Classe da instância do banco de dados"
  type        = string
}

variable "env" {
  description = "Ambiente de aplicação do terraform"
  type        = string
}