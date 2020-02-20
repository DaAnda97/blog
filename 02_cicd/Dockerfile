FROM jenkins/jenkins:lts

USER root
RUN apt-get update \
      && apt-get upgrade -y \
      && apt-get install -y sudo libltdl-dev ssh rsync \
      && rm -rf /var/lib/apt/lists/*
      
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

# Fixes socket permissions within build containers
RUN groupadd -for -g 998 docker # echo $(stat -c '%g' /var/run/docker.sock)
RUN usermod -aG docker jenkins

USER jenkins
