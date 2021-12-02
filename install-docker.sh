#!/bin/sh

set -eu

apt-get update
apt-get upgrade
apt-get install

# For adding PPA (Personal Package Archive) - needed for docker installation
apt-get install -y software-properties-common

# Docker
sudo apt remove --yes docker docker-engine docker.io \
    && sudo apt update \
    && sudo apt --yes --no-install-recommends install \
        apt-transport-https \
        ca-certificates \
    && wget --quiet --output-document=- https://download.docker.com/linux/ubuntu/gpg \
        | sudo apt-key add - \
    && sudo add-apt-repository \
        "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu \
        $(lsb_release --codename --short) \
        stable" \
    && sudo apt update \
    && sudo apt --yes --no-install-recommends install docker-ce \
    && sudo usermod --append --groups docker "$USER" \
    && sudo systemctl enable docker \
    && printf '\nDocker installed successfully\n\n'

printf 'Waiting for Docker to start...\n\n'
sleep 3
    
# ensure logging doesn't flood disk
printf "{\n\"log-driver\": \"json-file\",\n\"log-opts\": {\n \"max-size\": \"10m\",\n \"max-file\": \"2\"\n }\n}"  > /etc/docker/daemon.json
systemctl reload docker
    
