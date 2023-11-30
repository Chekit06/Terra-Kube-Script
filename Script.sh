#!/bin/bash

# Initialize Terraform
terraform init

# Apply Terraform configuration to provision infrastructure
terraform apply -auto-approve

# Capture Terraform outputs
master_ip=$(terraform output master_ip)
worker_ips=$(terraform output worker_ips)

# Initialize the Kubernetes cluster on the master node using kubeadm
ssh user@${master_ip} 'sudo kubeadm init --pod-network-cidr=10.244.0.0/16'

# Configure kubectl on the local machine to access the cluster
mkdir -p $HOME/.kube
scp user@${master_ip}:/etc/kubernetes/admin.conf $HOME/.kube/config

# Install a pod network add-on (e.g., Flannel)
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Get the join command from the master node
join_command=$(ssh user@${master_ip} 'sudo kubeadm token create --print-join-command')

# Join worker nodes to the cluster
for worker_ip in ${worker_ips[@]}; do
    ssh user@${worker_ip} "${join_command}"
done
