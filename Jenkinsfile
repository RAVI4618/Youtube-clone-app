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

          
     }   
 
}