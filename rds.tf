# rds subnet group
resource "aws_db_subnet_group" "sub-group" {
  name       = "main"
  subnet_ids = [aws_subnet.prvt7.id, aws_subnet.prvt8.id]
  depends_on = [aws_subnet.prvt7, aws_subnet.prvt8]

  tags = {
    Name = "My DB subnet group"
  }
}

# rds creation
resource "aws_db_instance" "db" {
  allocated_storage    = 20
  identifier           = "book-rds"
  db_subnet_group_name = aws_db_subnet_group.sub-group.id
  engine                 = "mysql"
  engine_version         = "8.0.32"
  instance_class         = "db.t3.micro"
  multi_az               = true
  db_name                = "mydb"
  username               = var.rds-username
  password               = var.rds-password
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.book-rds-sg.id]
  depends_on             = [aws_db_subnet_group.sub-group]
  publicly_accessible    = false



  tags = {
    DB_identifier = "book-rds"
  }
}
