#-----loadbalancing/main.tf

resource "aws_lb" "demo_lb" {
  name            = "demo-loabalancer"
  subnets         = var.public_subnets
  security_groups = var.public_sg
  idle_timeout    = 400
}

resource "aws_lb_target_group" "demo_tg" {
  name     = "demo-lb-tg-${substr(uuid(), 0, 3)}"
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.vpc_id
  lifecycle {
    ignore_changes = [name]
    create_before_destroy = true
  }
  health_check {
    healthy_threshold   = var.lb_healthy_thresold
    unhealthy_threshold = var.lb_unhealthy_threshold
    timeout             = var.lb_timeout
    interval            = var.lb_interval
  }
}

resource "aws_lb_listener" "demo_lb_listener" {
  load_balancer_arn = aws_lb.demo_lb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.demo_tg.arn
  }
}

resource "aws_lb_listener_rule" "lb_lr" {
  listener_arn = aws_lb_listener.demo_lb_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.demo_tg.arn
  }

  condition {
    path_pattern {
      values = ["/static/*"]
    }
  }
}