# Blog
This repository contains all files I mentioned in my blog posts: https://andreasriepl.de/

## Install Docker
1. Create User
   ```
   useradd -m -s /bin/bash <USER>
   cd /home/<USER>/
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
   usermod -a -G docker <USER>
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
