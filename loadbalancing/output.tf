#---loadbalancing/output.tf

output "loadbalancer_id" {
  value = aws_lb.demo_lb.id
}

output "demo_tg_arn" {
  value = aws_lb_target_group.demo_tg.arn
}