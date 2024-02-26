@Library('JenkinsLib_Shared') _

// Configurations des serveurs
def remote

pipeline {
    agent any

    environment {

        DOMAIN_REGISTRY = "sonatype-nexus.backhole.ovh"
        DEPLOY = false
        ROLLBACK = false
        // Get credentials to connection serveur
        Preprod_CREDS = credentials('PREPROD')

    }

    stages {

        stage('Load Environment Variables') {
            steps {
                script {
                    echo "L'espace de travail : ${WORKSPACE}";

                    // lecture du fichier
                    def envContent = readFile(".env").trim()

                    // Séparer le contenu en lignes et traiter chaque ligne
                    envContent.readLines().each { line ->
                        // Diviser la ligne en clé et valeur
                        def (key, value) = line.split('=').collect { it.trim() }

                        // Définir la variable d'environnement dans le contexte du pipeline
                        env."${key.trim()}" = value.trim()
                    }

                    // Afficher les variables d'environnement pour le débogage
                    env.each { key, value ->
                        echo "${key}=${value}"
                    }

                    echo "Nouvelle version de l'application : ${IMAGE_VERSION}";
                }
            }
        }

        stage("Open connection") {
            steps {
                script {
                    // definition config serveur
                    remote = configurerServeur.config('Preprod', '192.168.1.27', true)
                    remote.user = env.Preprod_CREDS_USR
                    remote.password = env.Preprod_CREDS_PSW

                    echo("Ouverture de connection au depot nexus sur le serveur Preprod")
                    withCredentials([usernamePassword(credentialsId: 'nexus-credentials', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {

                        String loginResult = sshCommand remote: remote, failOnError: false, sudo: false,
                                command: "docker login -u $USERNAME -p $PASSWORD $DOMAIN_REGISTRY"

                        loginResult.contains("status: 401 Unauthorized") ? error("Erreur de connection status: 401 Unauthorized") :
                                echo("Connection au dépôt depuis le serveur réussi : Login Succeeded")
                    }

                    echo("Mise à jours du projet ms-article sur le serveur Preprod")
                    // Pull projet sur branch preprod
                    //String commande = sshCommand remote: remote, command: "cd /home/max/docker_home/ms-eureka &&  git checkout preprod && git pull origin preprod"
                    String commande = sshCommand remote: remote, failOnError: false, sudo: false,
                            command: "cd /home/max/docker_home/ms-eureka &&  git pull origin dev"

                    echo("sorti : $commande")
                }
            }
        }

        // Détermine Update ou deploy
        stage("Status stack : eureka") {
            steps {
                script {
                    echo("Vérifi si la stack $NAME_SERVICE est créer ")
                    String result = ""
                    try {
                        result = sshCommand remote: remote, failOnError: false, sudo: false,
                                command: "docker stack ls | grep $NAME_SERVICE"

                        result.contains($NAME_SERVICE) ? DEPLOY = true : false
                        echo "La stack $NAME_SERVICE est " + (DEPLOY ? "déployée" : "non déployée") + " sur le serveur"
                    } catch (Exception e) {
                        echo("La Stack $NAME_SERVICE n'a pas etait trouver !!!")
                    }

                }
            }
        }


        stage("Maven Compilation") {
            agent {
                docker {
                    image 'maven:3.8.5-jdk-8-slim'
                    args '-v /var/jenkins_home/maven/.m2:/root/.m2' +
                            ' -v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                script {
                    echo("Compilation du projet ms-configuration")
                    sh '''
                        mvn clean package -Dspring.profiles.active=dev
                    '''
                }
            }
        }

        stage('Build Docker compose') {
            agent any
            steps {
                script {
                    echo("Création de l'image Docker : $env.DOCKER_IMAGE_NAME:$env.IMAGE_VERSION ")
                    sh '''
                        docker compose build --no-cache
                    '''
                }
            }
        }

        stage('Push image dépôt') {
            agent any
            steps {
                script {
                    echo("push de l'image $env.DOCKER_IMAGE_NAME:$env.IMAGE_VERSION vers le dépôt")
                    def pushResult = docker.image("$env.DOCKER_IMAGE_NAME:$env.IMAGE_VERSION").push()
                    echo("Sorti push : $pushResult")
                }
            }
        }


        stage('Deploy ms-eureka') {
            agent any
            when {
                expression { return env.DEPLOY }
            }
            steps {
                script {

                    // pull depuis preprod
                    String pullResult = sshCommand remote: remote, command: "docker pull " +
                            "$env.DOCKER_IMAGE_NAME:$env.IMAGE_VERSION"

                    echo("Sorti pull : $pullResult")

                    pullResult.contains("Status: Downloaded newer image") ?
                            echo("Le pull de l'image sur le serveur Preprod a été réalisé avec succès.") :
                            error("Erreur lors du pull de l'image.")
                    try {
                        def deployResult = sshCommand remote: remote, failOnError: false, sudo: false,
                                command: "cd /home/max/docker_home/ms-eureka && export \$(cat .env) && " +
                                        "docker stack deploy -c ./docker-compose-swarm.yml $env.STACK_NAME"

                        echo("Sorti deployResult : $deployResult")

                        if (deployResult == "Creating service $NAME_SERVICE") {
                            echo("Le déployement à été réaliser avec succès : $deployResult")
                        }

                    } catch (Exception e) {
                        e.printStackTrace()
                        error("Une erreur est survenu pendant le deployment")
                    }

                }

            }
        }

        stage('Update ms-eureka') {
            agent any
            when {
                expression { return !env.DEPLOY }
            }
            steps {
                script {
                    // Pull image in preprod and update with image
                    def deployResult = sshCommand remote: remote, failOnError: false, sudo: false,
                            command: "docker pull $env.DOCKER_IMAGE_NAME:$env.IMAGE_VERSION && " +
                                    "docker service update --image $env.DOCKER_IMAGE_NAME:$env.IMAGE_VERSION $NAME_SERVICE"
                    env.ROLLBACK = true

                }
            }
        }

        // Teste la santer du service (dans la stack)
        stage('Test du service ') {
            agent any
            steps {
                script {

                    for (int index = 0; index < 10; index++) {

                        echo("Requet CURL n° $index du service : $NAME_SERVICE a l'adresse : http://192.168.1.27:8099/actuator/health ")
                        def result = sh(script: "curl -s http://192.168.1.27:8099/actuator/health", returnStatus: true)

                        echo("result $result")

                        if (result == 0) {
                            echo("La mise en service de $NAME_SERVICE à été réalisé avec Succès ")
                            currentResult = "SUCCESS"
                            break
                        } else {
                            echo "Le service n'est pas encore UP. Attente de 15 secondes..."
                            echo "Tentative n° $index"
                            sleep time: 15, unit: 'SECONDS'
                        }
                    }
                    if (currentResult != "SUCCESS") {
                        error("Le service $NAME_SERVICE est en echec !!!")
                    }
                }
            }
        }
    }


    post {
        always {
            script {
                echo "Fin de " + (env.DEPLOY ? "La mise en service " : "la mise en service")

            }
        }
        success {

            script {
                echo('Réussite du build')
                String loginResult = sshCommand remote: remote, failOnError: false, sudo: false,
                        command: "docker logout $DOMAIN_REGISTRY"

                if (loginResult.contains("Removing login credentials")) {
                    echo "La deconnection au dépôt depuis le serveur réussi"
                } else {
                    error("Echec de la deconnexion au dépot depuis le serveur Preprod")
                }
            }


        }
        failure {
            script {

                echo("Échec du build ");

                // Si update effectuer
                if (env.ROLLBACK) {
                    echo("ROLLBACK ...");
                    String rollbackResult = sshCommand remote: remote, command: "docker service rollback $NAME_SERVICE"
                    echo("Sorti ROLLBACK : $rollbackResult")

                }

                // Logout du depot sur preprod
                String loginResult = sshCommand remote: remote, command: "docker logout $DOMAIN_REGISTRY"
                if (loginResult.contains("Removing login credentials")) {
                    echo "La deconnection au dépôt depuis le serveur réussi"
                } else {
                    error("Echec de la deconnexion au dépot depuis le serveur Preprod")
                }
            }
        }
    }
}