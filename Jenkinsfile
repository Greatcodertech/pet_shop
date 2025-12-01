pipeline {
    agent any

    stages {
        stage('Checkout Code from GitHub') {
            steps {
                git branch: 'main', url: 'https://github.com/Greatcodertech/pet_shop.git'
            }
        }

        stage('Build Project (Maven)') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
    }
}
