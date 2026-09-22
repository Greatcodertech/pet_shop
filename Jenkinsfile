pipeline {
    agent any

    stages {

        stage('Get The Code from Git') {
            steps {
                git branch: 'main', url: 'https://github.com/Greatcodertech/pet_shop.git'
            }
        }

        stage('Build the Code') {
            steps {
                sh 'mvn clean package'
            }
        }

    }
}
