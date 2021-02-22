resource "aws_db_subnet_group" "itea-subnetgroup" {
  name       = "itea-subnetgroup"
  subnet_ids = [aws_subnet.itea-subnet-1.id, aws_subnet.itea-subnet-2.id]

  tags = {
    Name = "itea-subnetgroup"
  }
}


resource "aws_db_instance" "itea-db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  name                 = "iteadb"
  username             = "iteauser"
  password             = "q1q1q1q1"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = "itea-subnetgroup"
  vpc_security_group_ids = [aws_security_group.itea-db-sg.id,]

}
