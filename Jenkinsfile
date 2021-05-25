pipeline {
    agent any

    tools{
        maven "3.8.1"
    }

    stages {

        stage('Stop service ... '){

            steps{
                // arrête du service
                sh """echo max | sudo -S systemctl stop gateway-service"""
            }

        }

        stage('build ...'){

            steps{
            sh """mvn -version"""
            sh """mvn clean install"""
            }
        }

        stage('Start service ... '){

            steps{
                // recherchement des deamons
                  sh """echo max | sudo -S systemctl daemon-reload"""

                // lancement du service
                sh """echo max | sudo -S systemctl start gateway-service"""
            }

        }
    }

    post {
        // raffraichi le workspace
        always {
            cleanWs()
        }
  }
}
