module "rds" {
    source = "./modules/rds"

    postgres_database_engine_version = var.postgres_database_engine_version
    env = var.env
    postgres_database_instance_class = var.postgres_database_instance_class
    postgres_database_name = var.postgres_database_name
    postgres_database_password = var.postgres_database_password
    postgres_database_username = var.postgres_database_username
}