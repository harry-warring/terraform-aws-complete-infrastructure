resource "aws_kms_key" "rds_db_key" {
  description = "Example KMS Key"
}

resource "aws_db_instance" "rds_db" {
  allocated_storage     = 10
  max_allocated_storage = 20
  db_name               = "mydb"
  engine                = "mysql"
  engine_version        = "8.0"
  instance_class        = "db.t4g.micro"
  username              = "Harry"
  # manage_master_user_password   = true
  # master_user_secret_kms_key_id = aws_kms_key.rds_db_key.id
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.rds_subnet.name
}

#Placing database in private subnet
resource "aws_db_subnet_group" "rds_subnet" {
  name       = "rds_subnet"
  subnet_ids = [aws_subnet.private-subnet-a.id, aws_subnet.private-subnet-b.id]

  tags = {
    Name = "My DB subnet group"
  }
}
