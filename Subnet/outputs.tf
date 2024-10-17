output "sub-pub" {
  value = aws_subnet.subnet-pub["public-subnet"].id
}

output "sub-pri" {
  value = aws_subnet.subnet-pri["private-subnet"].id
}


