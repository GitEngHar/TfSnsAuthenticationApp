output "vpn_id" {
  description = "The ID of the vpn"
  value = aws_vpc.main.id
}

output "public-a_id" {
  description = "The ID to use for the subnet"
  value = aws_subnet.public-a.id
}

output "public-c_id" {
  description = "The ID to use for the subnet"
  value = aws_subnet.public-c.id
}

output "private-a_id" {
  description = "The ID to use for the subnet"
  value = aws_subnet.private-a.id
}