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

        // 🔐 SECURE DOCKER HUB LOGIN
        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockercre',
                    usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                }
            }
        }

        // ⬆ PUSH IMAGE TO DOCKER HUB
        stage('Push Docker Image') {
            steps {
                sh '''
                docker tag myapp:latest $USERNAME/myapp:latest
                docker push $USERNAME/myapp:latest
                '''
            }
        }
    }
}
