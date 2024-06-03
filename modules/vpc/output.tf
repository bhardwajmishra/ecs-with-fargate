output "vpc_id" {
    value = aws_vpc.main.id
}

output "aws_subnet_main_a" {
    value = aws_subnet.main_a.id
}

output "aws_subnet_main_b" {
    value = aws_subnet.main_b.id
}

output "aws_subnet_main_c" {
    value = aws_subnet.main_c.id
}

output "aws_security_group_main" {
    value = aws_security_group.main.id

}