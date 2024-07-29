pipeline {
    agent any
    tools {
        jdk 'jdk17'
        nodejs 'nodejs'
    }
    environment {
        APP_NAME = "youtube-clone"
        RELEASE = "1.0.0"
        DOCKER_USER = "gundala22reddy"
        IMAGE_NAME = "${DOCKER_USER}/${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
    }
    stages {
        stage('Clean workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/kamalakar22/Youtube-clone-app.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Trivy FS Scan') {
            steps {
                sh "trivy fs . > trivyfs.txt"
                archiveArtifacts artifacts: 'trivyfs.txt', allowEmptyArchive: true
            }
        }
        stage('Docker Buildx Build') {
            steps {
                script {
                    // Create and use a new buildx builder instance
                    sh 'docker buildx create --name mybuilder --use || true'

                    // Build Docker image with Buildx
                    echo "Building Docker image with buildx: ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh """
                        docker buildx build \
                        --tag ${IMAGE_NAME}:${IMAGE_TAG} \
                        --tag ${IMAGE_NAME}:latest \
                        --file Dockerfile \
                        --output type=docker \
                        .
                    """
                }
            }
        }
        stage('Trivy Image Scan') {
            steps {
                script {
                    // Perform Trivy scan on the Docker image
                    echo "Scanning Docker image with Trivy: ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "trivy image --format json --output trivyimage.json ${IMAGE_NAME}:${IMAGE_TAG}"
                    archiveArtifacts artifacts: 'trivyimage.json', allowEmptyArchive: true
                }
            }
        }
        stage('Docker Push') {
            steps {
                script {
                    // Login to Docker Hub
                    echo "Logging in to Docker Hub"
                    withCredentials([string(credentialsId: 'dockerhub', variable: 'DOCKERHUB_CRED')]) {
                        sh 'echo $DOCKERHUB_CRED | docker login -u $DOCKER_USER --password-stdin'
                    }

                    // Push Docker image
                    echo "Pushing Docker image: ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker push ${IMAGE_NAME}:latest"
                }
            }
        }
        stage('Remove Docker Image') {
            steps {
                script {
                    // Remove Docker image from the local system
                    echo "Removing Docker image: ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG} || true"  // Use || true to ignore errors if the image is not found
                    sh "docker rmi ${IMAGE_NAME}:latest || true"  // Also remove the 'latest' tag if present
                }
            }
        }
    }
    post {
        success {
            echo 'Build succeeded!'
        }
        failure {
            echo 'Build failed!'
        }
        always {
            cleanWs()
        }
    }
}
