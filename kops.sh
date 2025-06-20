#vim .bashrc
#export PATH=$PATH:/usr/local/bin/
#source .bashrc


#! /bin/bash

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops
sudo mv kops /usr/local/bin/kops
chmod +x kubectl
mv kubectl /usr/local/bin/

aws s3api create-bucket --bucket balu.project.k8s.local --region us-east-1
aws s3api put-bucket-versioning --bucket balu.project.k8s.local --region us-east-1 --versioning-configuration Status=Enabled
export KOPS_STATE_STORE=s3://balu.project.k8s.local
kops create cluster --name balu.project.k8s.local --zones us-east-1a,us-east-1b --master-count=1 --master-size t2.medium --master-volume-size=25 --node-count=2 --node-size t2.micro --node-volume-size=25
kops update cluster --name balu.project.k8s.local --yes --admin
