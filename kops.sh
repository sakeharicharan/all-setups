#! /bin/bash
aws configure
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
wget https://github.com/kubernetes/kops/releases/download/v1.33.0/kops-linux-amd64
chmod +x kops-linux-amd64 kubectl
mv kubectl /usr/local/bin/kubectl
mv kops-linux-amd64 /usr/local/bin/kops
echo "export PATH=$PATH:/usr/local/bin/" >> source .bashrc

export KOPS_STATE_STORE=s3://haricharan.k8s.local
kops create cluster --name hari.k8s.local --zones ap-south-1a --control-plane-image ami-0d176f79571d18a8f --control-plane-count=1 --control-plane-size c7i-flex.large --image ami-0d176f79571d18a8f --node-count=2 --node-size c7i-flex.large
kops update cluster --name hari.k8s.local --yes --admin
