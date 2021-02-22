resource "aws_elb" "iac-elb" {
  name               = "iac-elb"

  subnets = [aws_subnet.iac-subnet-1.id]

  security_groups = [ aws_security_group.iac-ubnt-sg.id ]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = [aws_instance.ubuntu-SERVER-1.id,aws_instance.ubuntu-SERVER-2.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "iac-elb"
  }
}
