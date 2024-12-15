# front-end target group
resource "aws_lb_target_group" "front_end" {
  name       = "frontend-tg"
  port       = 80
  protocol   = "HTTP"
  vpc_id     = aws_vpc.three-tier.id
  depends_on = [aws_vpc.three-tier]

}
# alb for front end server
resource "aws_lb" "front-end" {
  name            = "front-end-alb"
  subnets         = [aws_subnet.pub1.id, aws_subnet.pub2.id]
  security_groups = [aws_security_group.frontend-server-sg.id]
  tags = {
    Name = "ALB-Frontend"
  }
  depends_on = [aws_lb_target_group.front_end]
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front-end.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
  depends_on = [ aws_lb_target_group.front_end ]
}
