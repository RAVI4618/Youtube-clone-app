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

            steps {
                // Checkout your code
                git 'https://github.com/your-username/your-repo.git'

                // Install dependencies and build
                sh 'npm install'
                sh 'npm run build'
            }
        }
        
        // Add more stages as needed
    }
}
