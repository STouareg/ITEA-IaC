resource "aws_db_subnet_group" "IaC-subnetgroup" {
  name       = "IaC-subnetgroup"
  subnet_ids = [aws_subnet.IaC-subnet-1.id, aws_subnet.IaC-subnet-2.id]

  tags = {
    Name = "IaC-subnetgroup"
  }
}


resource "aws_db_instance" "IaC-db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  name                 = "iacdb"
  username             = "iacuser"
  password             = "q1q1q1q1"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = "IaC-subnetgroup"
  vpc_security_group_ids = [aws_security_group.IaC-db-sg.id,]

}
