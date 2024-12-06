


# Output the VPC ID
output "vpc_id" {
  value = aws_vpc.demo_vpc.id
}
output "public_subnet_a_id" {
  value = aws_subnet.public_subnet_a.id
}

output "private_route_table" {
  value = aws_route_table.private_route_table.id

}