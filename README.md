# Terra-Kube-Script
Bash script that uses Terraform to provision a Kubernetes cluster and worker nodes on AWS using the kubeadm tool to set up the cluster and join worker nodes.

This script assumes that Terraform is used to provision infrastructure, capture outputs like master and worker nodes' IPs, and then uses SSH to remotely execute commands on these nodes.

Here's a breakdown:

Terraform provisions infrastructure.
Captures outputs (master IP and worker IPs).
Initializes the Kubernetes cluster on the master node using kubeadm.
Configures kubectl on the local machine to access the cluster.
Installs a pod network add-on (Flannel in this case) to enable pod communication.
Retrieves the join command from the master node and uses SSH to join worker nodes to the cluster.
Replace user, master_ip, worker_ips, and any placeholders with your actual values.

Remember, this script simplifies the process and might need adjustments based on your specific environment and security configurations. Always ensure you follow best practices and secure your infrastructure properly.
