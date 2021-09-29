pipeline {
    agent any

    tools{
        maven "3.8.1"
    }

    stages {

        stage('Stop eureka-service '){

            steps{
                // stop service
                sh """echo max | sudo -S systemctl stop eureka-service"""
            }

        }

        stage('build ...'){

            steps{
            sh """mvn -version"""
            sh """mvn clean install -Dspring-boot.run.jvmArguments=-Dspring.profiles.active=prod"""
            }
        }

        stage('Start eureka-service '){

            steps{

                // reload service
                  sh """echo max | sudo -S systemctl daemon-reload"""

                // Run du service
                sh """echo max | sudo -S systemctl start eureka-service"""
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
