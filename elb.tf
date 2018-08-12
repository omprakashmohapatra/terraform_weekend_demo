# Create a new load balancer
resource "aws_elb" "prod_elb" {
  name               = "ProductionELB"
  subnets            = ["${aws_subnet.prod_subnet.*.id}"]
  security_groups    = ["${aws_security_group.allow_all.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTP:80/index.html"
    interval            = 20
  }

  instances                   = ["${aws_instance.prod_server.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 60
  connection_draining         = true
  connection_draining_timeout = 60

}
