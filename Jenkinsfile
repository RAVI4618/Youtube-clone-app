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
        stage('Clean') {
            steps {
                cleanWs()
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    def dockerimage = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }
    }
}
