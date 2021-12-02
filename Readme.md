# Blog
This repository contains all files I mentioned in my blog posts: https://andreasriepl.de/

## Install Docker
1. Create User and generate ssh key
   ```
   useradd -m -s /bin/bash andreas
   cd /home/andreas
   su andreas
   ssh-keygen 
   mkdir -p ~/.ssh
   touch ~/.ssh/authorized_keys-t rsa
   cat ~/id_rsa.pub >> ~/.ssh/authorized_keys
   ```

1. Install Docker
   ```bash
   apt-get install -y git
   git clone https://github.com/DaAnda97/blog.git ./ServerInfrastructure
   cd ServerInfrastructure
   sh install-docker.sh
   ```

1. Register user for docker and create network
   ``` bash
   usermod -a -G docker andreas
   systemctl restart docker
   docker network create proxy
   ```

1. Other apps:
   ```
   # Networking information
   apt install net-tools
   
   # Check for security updates every night and install them.
   apt-get install -y unattended-upgrades
   ```
