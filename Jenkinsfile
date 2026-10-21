pipeline {
    agent any

    stages {
        stage('Get the code from Github') {
            steps {
                git branch: 'main', url: 'https://github.com/Greatcodertech/pet_shop.git'
            }
        }
        stage('Build the code') {
            steps {
                sh ' mvn clean package '
            }
        }
        stage('Deploy Application') {
            steps {
                deploy adapters: [tomcat9(alternativeDeploymentContext: '', credentialsId: 'cred', path: '', url: 'http://13.203.213.139:8090/')], contextPath: 'apps', war: '**/*.war'
            }
        }
    }
}
