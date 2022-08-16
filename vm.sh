#! /bin/bash

while [ "$(hostname -I)" = "" ]; do
  echo -e "\e[1A\e[KNo network: $(date)"
  sleep 1
done
echo "I have network";

resource_group_name=${resource_group_name}
storage_account_name=${storage_account_name}

sudo apt-add-repository -y 'deb http://archive.ubuntu.com/ubuntu/ kinetic main restricted'
sudo apt-add-repository -y 'deb http://archive.ubuntu.com/ubuntu/ kinetic-updates main restricted'
sudo apt-add-repository -y 'deb http://archive.ubuntu.com/ubuntu/ kinetic universe'
sudo apt-add-repository -y 'deb http://archive.ubuntu.com/ubuntu/ kinetic-updates universe'
sudo apt-add-repository -y 'deb http://archive.ubuntu.com/ubuntu/ kinetic-backports main restricted universe multiverse'

sudo apt update

echo '* libraries/restart-without-asking boolean true' | sudo debconf-set-selections

sudo apt install -y podman

sudo apt-get update
sudo apt-get install -y ca-certificates curl apt-transport-https lsb-release gnupg
curl -sL https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
AZ_REPO="bullseye" # $(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-get update
sudo apt-get install -y azure-cli

az extension add --name storage-preview

az login --identity

# app
sudo mkdir /var/app/
sudo touch /var/app/error.log
sudo touch /var/app/access.log
sudo az storage blob directory download --container "demo" --account-name $storage_account_name --source-path "*" --destination-path "/var/app/" --recursive
# sudo az storage blob directory download --container "demo" --account-name "demo3localdso" --source-path "*" --destination-path "/var/app/" --recursive
sudo podman run -p 443:443 --name app --restart unless-stopped --replace --tls-verify --pull always -d -v /var/app/error.log:/var/log/nginx/error.log -v /var/app/access.log:/var/log/nginx/access.log -v /var/app/:/var/app/ ghcr.io/devstarops-org/setting-up-nginx-on-azure-vms-behind-cloudflare-using-terraform:main


# Debug Things
# cat /etc/apt/sources.list
# cat /var/log/cloud-init-output.log

