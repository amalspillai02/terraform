provider "aws" {
  region = "ap-south-1"  # change if needed
}

resource "aws_db_instance" "mariadb" {
  identifier              = "my-mariadb-instance"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mariadb"
  engine_version          = "11.4.4"
  instance_class          = "db.t3.micro"
  db_name                 = "mydatabase"
  username                = "admin"
  password                = "Adminpassowrd"
  skip_final_snapshot     = true
  publicly_accessible     = true
  vpc_security_group_ids  = ["sg-0ff687dfa74cda1d4"]  # Your security group
  multi_az                = false
  backup_retention_period = 0
  deletion_protection     = false

  tags = {
    Name = "MariaDB-FreeTier"
  }
}

