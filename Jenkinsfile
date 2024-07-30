pipeline {
    agent any
    tools{
        jdk 'jdk17'
        nodejs 'nodejs'
    }
    environment{
        DOCKER_USER = "gundala22reddy"
        APP_NAME = "youtube-clone"
        RELEASE = "1.0.0"
        TAG = "${RELEASE}-{BUILD_ID}"
        IMAGE = "${DOCKER_USER}/${APP_NAME}:${TAG}"
    }  
    stages{
        stage('Clean'){
            steps{
                CleanWs()
            }
        }
        
    }
}
