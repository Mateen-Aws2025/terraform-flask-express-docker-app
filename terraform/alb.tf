# =========================
# Application Load Balancer
# =========================
resource "aws_lb" "alb" {
  name               = "${var.project_name}-alb"
  load_balancer_type = "application"
  subnets            = aws_subnet.public[*].id
  security_groups    = [aws_security_group.alb_sg.id]
}

# =========================
# Frontend Target Group (DETACHED)
# =========================
resource "aws_lb_target_group" "frontend" {
  name        = "${var.project_name}-frontend-tg"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }
}

# =========================
# Backend Target Group (DETACHED)
# =========================
resource "aws_lb_target_group" "backend" {
  name        = "${var.project_name}-backend-tg"
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "404"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# =========================
# ALB Listener (DETACHED)
# =========================
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  # TEMPORARY: no forwarding to any target group
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "detached"
      status_code  = "200"
    }
  }
}

# =========================
# Backend Listener Rule (INTENTIONALLY REMOVED)
# =========================
# DO NOT define aws_lb_listener_rule here in detach phase
