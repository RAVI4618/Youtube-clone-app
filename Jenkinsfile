pipeline {
    agent any
    tools {
        jdk 'jdk17'
    }
    environment {
        APP_NAME = "youtube-clone"
        RELEASE = "1.0.0"
        DOCKER_USER = "gundala22reddy"
        IMAGE_NAME = "${DOCKER_USER}/${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
    }
    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()  
            }
        }
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/RAVI4618/Youtube-clone-app.git'
            }
        }
        stage('Verify Files') {
            steps {
                sh 'ls -l' 
                sh 'cat package.json
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
