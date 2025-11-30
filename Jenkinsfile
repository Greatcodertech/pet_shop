pipeline {
    agent any

    environment {
        IMAGE_NAME = "myapp"
    }

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
                sh 'docker build -t ${IMAGE_NAME}:latest .'
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

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockercre',
                    usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                }
            }
        }

        stage('Tag & Push Docker Image') {
            steps {
                sh '''
                docker tag ${IMAGE_NAME}:latest $USERNAME/${IMAGE_NAME}:latest
                docker push $USERNAME/${IMAGE_NAME}:latest
                '''
            }
        }
    }

    post {
        success {
            echo "🚀 SUCCESS! Image pushed to Docker Hub."
        }
        failure {
            echo "❌ Build failed — check logs."
        }
    }
}
