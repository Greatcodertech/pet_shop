pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Greatcodertech/pet_shop.git'
            }
        }

        stage('Build Application') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t myapp:latest .'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker rm -f myapp-container || true
                docker run -d --name myapp-container -p 8081:8080 myapp:latest
                '''
            }
        }

        // 🔐 LOGIN TO DOCKER HUB (using Jenkins credentials: dockercre)
        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockercre',
                    usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                        sh 'echo $PASS | docker login -u greatcoderhyd --password-stdin'
                }
            }
        }

        // 📤 PUSH IMAGE TO DOCKER HUB (NO VARIABLES – SAFE)
        stage('Push Docker Image') {
            steps {
                sh '''
                docker tag myapp:latest greatcoderhyd/myapp:latest
                docker push greatcoderhyd/myapp:latest
                '''
            }
        }
    }

    post {
        success {
            echo "🚀 SUCCESS! Image pushed to Docker Hub: https://hub.docker.com/r/greatcoderhyd/myapp"
        }
        failure {
            echo "❌ Build failed — check logs. Will fix immediately."
        }
    }
}
