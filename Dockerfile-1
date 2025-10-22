environment {
    DOCKER_HUB_USER = 'greatcoderhyd'
    APP_NAME = 'pet-shop-app'
    IMAGE_TAG = 'latest'
    APP_PORT = '8082'  // change if 8080 is in use
}

stages {

    stage('Checkout Code from GitHub') {
        steps {
            git branch: 'main', url: 'https://github.com/Greatcodertech/pet_shop.git'
        }
    }

    stage('SonarQube Code Analysis') {
        environment {
            SONAR_TOKEN = credentials('sonar-token')  // Jenkins secret text ID
        }
        steps {
            withSonarQubeEnv('SonarQube') {
                sh '''
                echo "🔍 Running SonarQube Analysis..."
                sonar-scanner \
                  -Dsonar.projectKey=pet-shop \
                  -Dsonar.projectName="Pet Shop App" \
                  -Dsonar.sources=src \
                  -Dsonar.java.binaries=target \
                  -Dsonar.host.url=http://<YOUR-SONARQUBE-SERVER>:9000 \
                  -Dsonar.login=$SONAR_TOKEN
                '''
            }
        }
    }

    stage('Build Docker Image') {
        steps {
            sh '''
            echo "🐳 Building Docker image..."
            docker build -t $APP_NAME:$IMAGE_TAG -f Dockerfile .
            '''
        }
    }

    stage('Run Docker Container') {
        steps {
            sh '''
            echo "🚀 Running container..."
            docker rm -f $APP_NAME || true
            docker run -d -p $APP_PORT:8080 --name $APP_NAME $APP_NAME:$IMAGE_TAG
            '''
        }
    }

    stage('Push Image to Docker Hub') {
        steps {
            withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                sh '''
                echo "📦 Pushing image to Docker Hub..."
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
