
#Creating RDS with mySQL engine
resource "aws_db_instance" "prod_RDS" {
  name = "prod_database"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "prod_DB"
  username             = "omprakash"
  password             = "omprakash"
  # parameter_group_name = "default.mysql5.7"
  # db_subnet_group_name = "${aws_subnet.rds_subnet.*.id[0]}"
}


#Creating private subnets for DB and others
resource "aws_subnet" "rds_subnet" {
  count     = "${length(var.rds_cidr)}"
  vpc_id     = "${aws_vpc.prod_vpc.id}"
  cidr_block = "${var.rds_cidr[count.index]}"
  availability_zone   = "${var.azs[count.index]}"
  tags {
    Name = "RdsSubnet-${count.index + 1}"
  }
}
