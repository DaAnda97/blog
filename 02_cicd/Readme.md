# Jenkins and Nexus
Jenkins is a open-source deployment server which can listen to new commits in your repository, test, build and deploy your application.

## Installation

1. Run the `install.sh` file to create the needed files and set their permissions. Note: change the user-dir first!
   ``` bash
   sh install.sh
   ```

1. Get dockers group id and set it in Dockerfile
   ```
   echo $(stat -c '%g' /var/run/docker.sock)
   ```

1. Build the image
   ``` bash
   docker build -t custom-jenkins:latest .
   ```

1. Set service name
   ```
   echo "COMPOSE_PROJECT_NAME=cicd" > .env
   echo "DOMAIN=andreasriepl.de" >> .env
   ```


1. Run the service
   ```
   docker-compose up -d
   ```

## Initialisation Jenkins
1. Look up the admin password and open `jenkins.<YOUR_DOMAIN>` to access the application.
   ```
   docker exec -it jenkins /bin/bash
   cat /var/jenkins_home/secrets/initialAdminPassword
   exit
   ```

1. Unselect Folders in 'Custom Packages' during installation

## Initialisation Nexus
1. Look up the admin password and open `nexus.<YOUR_DOMAIN>` and press login.
   ```
   docker exec -it nexus /bin/bash
   cat /nexus-data/admin.password
   exit
   ```



## Example for gradle
```
pipeline {

    agent any

    environment {
        dockerImageTag = sh(returnStdout: true, script: '[ "$GIT_BRANCH" = "master" ] && echo latest || echo $GIT_BRANCH')
    }

    stages {

    stage('Setup') {
      when { expression { env.BRANCH_NAME ==~ /master/  } }
      steps {
        withCredentials([usernamePassword(credentialsId: 'nexus', passwordVariable: 'pass', usernameVariable: 'user')]) {
            sh "./gradlew -P nexusUser=$user -P nexusPassword=$pass clean"
        }
      }
    }

    stage('Test') {
      when { expression { env.BRANCH_NAME ==~ /master/  } }
        steps {
                withCredentials([usernamePassword(credentialsId: 'nexus', passwordVariable: 'pass', usernameVariable: 'user')]) {
                    sh "./gradlew -P nexusUser=$user -P nexusPassword=$pass test"
        }
      }
    }

    stage('Build') {
      when { expression { env.BRANCH_NAME ==~ /master/  } }
      steps {
         withCredentials([usernamePassword(credentialsId: 'nexus', passwordVariable: 'pass', usernameVariable: 'user')]) {
             sh "./gradlew -P nexusUser=$user -P nexusPassword=$pass bootRepackage"
         }
       }
    }

    stage('Dockerize') {
      when { expression { env.BRANCH_NAME ==~ /master/  } }
      steps {
        sh "docker build . -t hinterteilchen/vs-chat-service"
      }
    }

  }
}
```

## Example for maven
```
pipeline {

    agent {
        docker {
            image 'maven:latest'
            args '-v /root/.m2:/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        dockerImageTag = sh(returnStdout: true, script: '[ "$GIT_BRANCH" = "master" ] && echo latest || echo $GIT_BRANCH')
        MVN_SET = credentials('maven-global')
    }

  stages {

        stage('Setup') {
          when { expression { env.BRANCH_NAME ==~ /master/  } }
          steps {
            sh "mvn clean"
          }
        }

        stage('Install') {
          when { expression { env.BRANCH_NAME ==~ /master/  } }
          steps {
            sh 'mvn install -s $MVN_SET'
          }
        }

        stage('Test') {
          when { expression { env.BRANCH_NAME ==~ /master/  } }
          steps {
            sh "mvn test"
          }
        }

        stage('Package') {
          when { expression { env.BRANCH_NAME ==~ /master/  } }
          steps {
            sh "mvn package spring-boot:repackage"
          }
        }
    
        stage('Dockerize') {
          when { expression { env.BRANCH_NAME ==~ /master/  } }
          steps {
            sh "docker build . -t hinterteilchen/vs-chat-service"
          }
    }

  }
}
```


Reference: http://blog.francoisfaubert.com/2018/06/11/dockerized-jenkins-with-traefik-2.html

