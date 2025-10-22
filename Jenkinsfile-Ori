pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'greatcoderhyd'
        APP_NAME = 'pet-shop-app'
        IMAGE_TAG = 'latest'
        APP_PORT = '8082'  // You can change this if 8080 is busy
    }

    stages {

        stage('Checkout Code from GitHub') {
            steps {
                git branch: 'main', url: 'https://github.com/Greatcodertech/pet_shop.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                # Multi-stage Docker build handles Maven and WAR
                docker build -t $APP_NAME:$IMAGE_TAG -f Dockerfile .
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                # Remove any existing container with same name
                docker rm -f $APP_NAME || true

                # Run new container
                docker run -d -p $APP_PORT:8080 --name $APP_NAME $APP_NAME:$IMAGE_TAG
                '''
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
            docker tag $APP_NAME:$IMAGE_TAG $DOCKER_USER/$APP_NAME:$IMAGE_TAG
            docker push $DOCKER_USER/$APP_NAME:$IMAGE_TAG
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Pet Shop app deployed successfully! Visit: http://<EC2-PUBLIC-IP>:$APP_PORT"
        }
        failure {
            echo "❌ Build failed — please check Jenkins logs."
        }
    }
}
