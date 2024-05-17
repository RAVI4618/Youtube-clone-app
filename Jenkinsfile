pipeline {
    agent none  // Specify 'none' to prevent running any default agent

    stages {
        stage('Build in Docker') {
            agent {
                docker {
                    // Use the official Node.js Docker image
                    image 'node:latest'
                    // Mount the Docker socket to allow Docker commands within the container
                    args '-v /var/run/docker.sock:/var/run/docker.sock'
                }
            }

            stage('Sonar Scan') {
            steps {
                withCredentials([string(credentialsId: 'sonarqube-token', variable: 'SONAR_TOKEN')]) {
                    sh 'mvn sonar:sonar -Dsonar.login=${SONAR_TOKEN}'
                }
            }
        }
        }
        
        // Add more stages as needed
    }
}
