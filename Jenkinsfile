pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Greatcodertech/pet_shop.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                deploy adapters: [
                    tomcat9(
                        credentialsId: 'cred',
                        url: 'http://3.108.5.66:8090'
                    )
                ],
                contextPath: 'hello',
                war: '**/*.war'
            }
        }
    }
}
