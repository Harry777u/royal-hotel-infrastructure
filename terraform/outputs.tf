output "developer_vm_public_ip" {
  description = "Public IP address of the Royal Hotel developer VM"
  value       = aws_instance.royal_hotel_developer.public_ip
}
output "developer_vm_public_ip_for_ansible" {
  description = "EC2 public IP for Ansible"
  value       = aws_instance.royal_hotel_developer.public_ip
}