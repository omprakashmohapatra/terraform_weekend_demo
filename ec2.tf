
#Creating web_server in each subnet and AZs
resource "aws_instance" "prod_server" {
  count             = 2
  ami               = "${var.ami_linux}"
  instance_type     = "${var.instance_type}"
  availability_zone = "${var.azs[count.index]}"
  key_name          = "demo"
  vpc_security_group_ids   = ["${aws_security_group.allow_all.id}"]
  subnet_id         = "${aws_subnet.prod_subnet.*.id[count.index]}"
  associate_public_ip_address = true
  user_data                   = "${file("httpd.sh")}"
  tags {
    Name = "Webserver- ${count.index + 1}"
  }
}

#Security Group for EC2 instance
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.prod_vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
