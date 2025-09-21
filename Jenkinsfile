pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = "issa293/examjenkins"  
        GIT_REPO = "https://github.com/issa113/examjenkins.git"  
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: "${env.GIT_REPO}"
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
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub-creds',  
                    usernameVariable: 'DOCKER_USER', 
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    bat """
                        echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                    """
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                bat "docker push %DOCKER_HUB_REPO%:latest"
            }
        }

        stage('Deploy to Render') {
            steps {
                withCredentials([string(credentialsId: 'render-api-key', variable: 'RENDER_API_KEY')]) {
                    bat """
                        curl -X POST "https://api.render.com/v1/services/srv-d381u7ruibrs739fcoug/deploys" ^
                        -H "Authorization: Bearer %RENDER_API_KEY%" ^
                        -H "Content-Type: application/json"
                    """
                }
            }
        }
    }
}
