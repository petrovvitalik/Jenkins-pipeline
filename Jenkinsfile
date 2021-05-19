pipeline {

    agent {
        docker {
            image '13.53.212.54:8123/docker-images/jenkins-agent'
            args '--privileged -v /var/run/docker.sock:/var/run/docker.sock -u 0:0'
        }
    }

    stages {

        stage ('Build everything and push') {
            steps {
                git 'http://193.122.59.82:3000/petrovvitalik/boxfuse.git'
                sh 'cp daemon.json /etc/docker/'
                sh 'mvn package'
                sh 'docker build . -t webapp'
                sh 'docker login --username="docker" --password="123123" 13.53.212.54:8123'
                sh 'docker tag webapp 13.53.212.54:8123/images/webapp && docker push 13.53.212.54:8123/images/webapp'
            }
        }
        
        stage ('Run docker on web server') {
            steps {
                sshagent(['jenkins']) {
                 
                  sh '''ssh -o StrictHostKeyChecking=no root@13.51.163.86 << EOF
                  docker stop $(docker ps)
                  docker pull 13.53.212.54:8123/images/webapp
                  docker run --rm --name webapp -p 8080:8080 -d 13.53.212.54:8123/images/webapp
EOF'''
                }
            }
        }
    }
}