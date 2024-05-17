pipeline{
  agent any

     stages{
        stage('clean work space'){
            steps{
                cleanWs()
            }
        }

        stage('Git Checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/kamalakar22/Youtube-clone-app.git'
            }
        }
         stage('Build') {
            steps {
                // Run the build script
                sh 'npm run build'
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
 
}
