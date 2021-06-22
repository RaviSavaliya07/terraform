#---------ASG/main.tf

resource "aws_launch_template" "launch_template" {
  name_prefix   = "demo_launch_template"
  image_id      = var.asg_image_id
  instance_type = var.asg_instance_type
}

resource "aws_autoscaling_group" "asg" {
  name = "asg"
  availability_zones = var.asg_availability_zone
  desired_capacity   = var.asg_desire_capacity
  max_size           = var.asg_max_size
  min_size           = var.asg_min_size
  # load_balancers     = [var.loadbalancer_id]
  target_group_arns = [var.demo_tg_arn]
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  # lifecycle {
  #   ignore_changes = [load_balancers, target_group_arns]
  # }
}

# resource "aws_autoscaling_attachment" "asg_attachment_bar" {
#   autoscaling_group_name = aws_autoscaling_group.asg.id
#   elb                    = var.loadbalancer_id
#   # alb_target_group_arn   = var.demo_tg_arn
# }

