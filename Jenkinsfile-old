pipeline {
    agent any

    environment {
        IMAGE_NAME = "myapp"
        CONTAINER_PORT = "8080"
        HOST_PORT = "8081"
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

        stage('Test Credentials') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockercre',
                    usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh 'echo "USERNAME VALUE IS: $USERNAME"'
                }
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker rm -f ${IMAGE_NAME}-container || true
                docker run -d --name ${IMAGE_NAME}-container -p ${HOST_PORT}:${CONTAINER_PORT} ${IMAGE_NAME}:latest
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

        stage('Tag & Push Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockercre',
                    usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh '''
                        docker tag ${IMAGE_NAME}:latest $USERNAME/${IMAGE_NAME}:latest
                        docker push $USERNAME/${IMAGE_NAME}:latest
                        '''
                }
            }
        }
    }
}
