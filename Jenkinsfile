pipeline {
    agent any

    stages {
        stage('git stage') {
            steps {
                git branch: 'main', url: 'https://github.com/Greatcodertech/pet_shop.git'
            }
        }
        
        stage('build application stage') {
            steps {
                 sh 'mvn clean package'
            }
        }
    }
}
