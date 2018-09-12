# Networking outputs

output "Public Subnets" {
  value = "${join(", ", module.networking.public_subnets)}"
}

output "Private Subnets" {
  value = "${join(", ", module.networking.private_subnets)}"
}
