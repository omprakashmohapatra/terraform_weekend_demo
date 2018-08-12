output "elb_DNS" {
  value = "${aws_elb.prod_elb.dns_name}"
}
