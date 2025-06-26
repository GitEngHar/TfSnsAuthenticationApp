output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "public_a_id" {
  value = aws_subnet.public_a_subnet.id
}

output "public_c_id" {
  value = aws_subnet.public_c_subnet.id
}

output "private_a_id" {
  value = aws_subnet.private_a_subnet.id
}