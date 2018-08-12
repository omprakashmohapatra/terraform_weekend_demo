
#Creating Public Subnets for webservers
resource "aws_subnet" "prod_subnet" {
  count      = "${length(var.azs)}"
  vpc_id     = "${aws_vpc.prod_vpc.id}"
  cidr_block = "${var.subnet_cidr[count.index]}"
  availability_zone = "${var.azs[count.index]}"

  tags {
    Name = "Subnet-${count.index + 1}"
  }
}

#Creating IGW and adding to public subnet
resource "aws_internet_gateway" "prod_igw" {
  vpc_id = "${aws_vpc.prod_vpc.id}"

  tags {
    Name = "Production_IGT"
  }
}

#Creating Route table and adding to VPC and IGW
resource "aws_route_table" "prod_rt" {
  vpc_id = "${aws_vpc.prod_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.prod_igw.id}"
  }

  tags {
    Name = "Production_RT"
  }
}

#Adding the public subnets into IGW
resource "aws_route_table_association" "subnet_ass" {
  count         =  "${length(aws_subnet.prod_subnet.*.id)}"
  subnet_id      = "${aws_subnet.prod_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.prod_rt.id}"
}
