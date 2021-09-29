pipeline {
    agent any

    tools{
        maven "3.8.1"
    }

    stages {

        stage('Stop service eureka'){

            steps{
                // stop service
                sh """echo max | sudo -S systemctl stop eureka"""
            }

        }

        stage('build service eureka ...'){

            steps{
            sh """mvn -version"""
            sh """mvn clean install -Dspring.profiles.active=prod"""
            }
        }

        stage('Start service eureka'){

            steps{

                // reload service
                  sh """echo max | sudo -S systemctl daemon-reload"""

                // Run du service
                sh """echo max | sudo -S systemctl start eureka"""
            }

        }
    }

    post {
        // refresh workspace
        always {
            cleanWs()
        }
  }
}
