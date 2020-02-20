mkdir -p /opt/data/jenkins/dev-ops
mkdir -p /opt/data/jenkins/volume-caches/build-cache/composer
mkdir -p /opt/data/jenkins/volume-caches/build-cache/node/npm
mkdir -p /opt/data/jenkins/volume-caches/build-cache/node/gyp
mkdir -p /opt/data/jenkins/volume-caches/build-cache/node/cache
mkdir -p /opt/data/jenkins/volume-caches/build-cache/node/config
mkdir -p /opt/data/jenkins/volume-caches/build-cache/bower/local
mkdir -p /opt/data/jenkins/persistent-cache
mkdir -p /opt/data/jenkins_home

chown -R 1000:1000 /opt/data/jenkins
chown -R root:root /opt/data/jenkins/volume-caches
chmod -R 777 /opt/data/jenkins_home
chmod -R 777 /opt/data/jenkins/volume-caches
chown root:root -R /opt/data/portainer
chown root:root -R /opt/data/traefik
chmod 777 /var/run/docker.sock

mkdir -p /opt/data/nexus
chown -R 200:200 /opt/data/nexus/
