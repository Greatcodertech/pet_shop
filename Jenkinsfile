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
        stage('Deploy Application in Tomcat') {
            steps {
                deploy adapters: [tomcat9(alternativeDeploymentContext: '', credentialsId: 'sandeepcred', path: '', url: 'http://13.203.213.139:8090/')], contextPath: 'app', war: '**/*.war'
            }
        }
    }
}
