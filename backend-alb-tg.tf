# tg for backend
resource "aws_lb_target_group" "back_end" {
  name       = "back-end-tg"
  port       = 80
  protocol   = "HTTP"
  vpc_id     = aws_vpc.three-tier.id
  depends_on = [aws_vpc.three-tier]
}

# backend lb
resource "aws_lb" "back_end" {
    name               = "back-end-lb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.alb-backend-sg.id]
    subnets             = [aws_subnet.pub1.id, aws_subnet.pub2.id]
    depends_on = [ aws_lb_target_group.back_end ]
    tags = {
    Name = "ALB-backend"
  }
}

# back-end lb listner
resource "aws_lb_listener" "back_end" {
    load_balancer_arn = aws_lb.back_end.arn
    port              = "80"
    protocol          = "HTTP"
    default_action{
        target_group_arn = aws_lb_target_group.back_end.arn
        type             = "forward"

    }
    depends_on = [ aws_lb_target_group.back_end ]
}