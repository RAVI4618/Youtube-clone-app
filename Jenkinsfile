pipeline {
    agent any
    tools{
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
    stages{
        stage('Clean'){
            steps{
                 cleanWs()
            }
        }
    stage('Install Dependences'){
            steps{
                sh 'npm install'
            }
        }
    stage('Trivy Scan') {
            steps {
                sh 'trivy fs . > trivy.txt'
                archiveArtifacts artifacts: 'trivy.txt', allowEmptyArchive: true
            }
        }
    stage('Docker Build') {
            steps {
                script{
                    def dockerimage = docker.build("$IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }
    }
}
