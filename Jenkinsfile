pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('jekinstk')  
        DOCKER_HUB_REPO = "issa113/jenkinsjv"   // ⚠️ mets ton user DockerHub + repo
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/issa113/examjenkins.git'
            }
        }

        stage('Build with Maven') {
            steps {
                bat 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %DOCKER_HUB_REPO%:latest ."
            }
        }

        stage('Login to Docker Hub') {
            steps {
                bat "docker login -u %DOCKER_HUB_CREDENTIALS_USR% -p %DOCKER_HUB_CREDENTIALS_PSW%"
            }
        }

        stage('Push to Docker Hub') {
            steps {
                bat "docker push %DOCKER_HUB_REPO%:latest"
            }
        }
    }
}
