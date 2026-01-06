output "instance_id" {
  description = "ID of the Minecraft EC2 instance"
  value       = aws_instance.minecraft.id
}

output "public_ip" {
  description = "Public IPv4 address assigned to the instance"
  value       = aws_instance.minecraft.public_ip
}

output "public_dns" {
  description = "Public DNS name of the instance"
  value       = aws_instance.minecraft.public_dns
}
