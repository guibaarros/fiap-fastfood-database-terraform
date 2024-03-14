resource "aws_db_instance" "postgres_fiap_fastfood" {
  identifier            = "postgres-fiap-fastfood-${var.env}"
  allocated_storage     = 20
  storage_type          = "gp2"
  engine                = "postgres"
  engine_version        = var.postgres_database_engine_version
  instance_class        = var.postgres_database_instance_class
  db_name               = var.postgres_database_name
  username              = var.postgres_database_username
  password              = var.postgres_database_password
  publicly_accessible   = true
  skip_final_snapshot   = true
}