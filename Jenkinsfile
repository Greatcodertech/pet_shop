```groovy
pipeline {

    agent any

    stages {

        stage('Get The Code from Git') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Greatcodertech/pet_shop.git'
            }
        }

        stage('Build the Code') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Deploy in Tomcat') {
            steps {
                deploy adapters: [
                    tomcat9(
                        alternativeDeploymentContext: '',
                        credentialsId: 'JenkinsPipe',
                        path: '',
                        url: 'http://13.232.230.207:8085/'
                    )
                ],
                war: '**/*.war'
            }
        }

    }
}
```
