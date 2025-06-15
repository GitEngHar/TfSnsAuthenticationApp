output "sg_id_for_app_ecs" {
  description = "The ID of the sg for the ecs"
  value = aws_security_group.app-ecs
}

output "sg_id_for_app_alb" {
  description = "The ID of the sg for the alb"
  value = aws_security_group.app-alb
}

output "vpc_ingress_sg_id_for_allow_my_ip_ipv4" {
  description = "The ID of the sg for the allow my ip"
  value = aws_vpc_security_group_ingress_rule.allow-myip-ipv4
}

output "vpc_ingress_sg_id_for_allow_alb_ipv4" {
  description = "The ID of the sg for the allow my ip"
  value = aws_vpc_security_group_ingress_rule.allow-alb-ipv4
}

output "vpc_egress_sg_id_for_allow_all_alb_ip" {
  description = "The ID of the sg for the allow alb ip"
  value = aws_vpc_security_group_egress_rule.allow-allip-alb
}

output "vpc_egress_sg_id_for_allow_all_ecs_ip" {
  description = "The ID of the sg for the allow ecs ip"
  value = aws_vpc_security_group_egress_rule.allow-allip-ecs
}