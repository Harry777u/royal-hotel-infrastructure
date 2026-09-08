#!/bin/bash

set -e

echo "=== Terraform: Apply Infrastructure ==="
cd terraform
terraform apply -auto-approve

echo "=== Getting EC2 Public IP ==="
EC2_IP=$(terraform output -raw developer_vm_public_ip_for_ansible)

echo "EC2 IP: $EC2_IP"

echo "=== Updating Ansible Inventory ==="
cd ..

cat > ansible/inventory.ini <<EOF
[developer]
$EC2_IP ansible_user=ubuntu ansible_ssh_private_key_file=/home/labuser/royal-hotel-infrastructure/royal-hotel-key.pem
EOF

echo "=== Testing Ansible Connection ==="
ansible -i ansible/inventory.ini developer -m ping

echo "=== Configuring Developer VM ==="
ansible-playbook -i ansible/inventory.ini ansible/developer-setup.yml

echo "=== Deployment Completed Successfully ==="