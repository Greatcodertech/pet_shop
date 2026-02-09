pipeline {
    agent any

    stages {

        stage('Get the Code from GitHub') {
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

    }
}
