pipeline {
    agent any

    stages {

        stage('Checkout Code fro GitHub') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Greatcodertech/pet_shop.git'
            }
        }

        stage('Build the Application') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                deploy adapters: [
                    tomcat9(
                        alternativeDeploymentContext: '',
                        credentialsId: 'gcpass',
                        path: '',
                        url: 'http://54.67.103.44:8060'
                    )
                ],
                contextPath: 'ROOT',
                war: '**/*.war'
            }
        }

    }
}
