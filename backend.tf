terraform {
  backend "s3" {
    bucket         = "fiap-fastfood-database-terraform-state"
    key            = "terraform.tfstate"  
    region         = "us-east-1"          
    encrypt        = true                 
  }
}