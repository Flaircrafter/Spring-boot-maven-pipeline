pipeline {
    agent any

    environment { 
        registry = "kesh1990/tomcat-demo" 
        registryCredential = 'dock_hub_id' 
        dockerImage = '' 
    }
    
    tools{
        maven 'Maven'
        jdk 'Java'
    }
    stages {
        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }

        stage ('Pull Source Code') {
            steps {
                git branch: 'master', url: "https://github.com/Flaircrafter/spring-boot-maven-example-helloworld.git"
            }
        }

        stage ('Build') {
            steps {
                sh 'mvn -Dmaven.test.failure.ignore=true install'
            }
        }
        
        stage('Creating Container Image') { 
            steps { 
                script { 
                    dockerImage = docker.build registry + ":$BUILD_NUMBER" 
                }
            } 
        }
        
        stage('Pushing image to dockerhub') { 
            steps { 
                script { 
                    docker.withRegistry( '', registryCredential ) { 
                        dockerImage.push() 
                    }
                } 
            }
        } 
        
        stage('Cleaning up') { 
            steps { 
                sh "docker rmi $registry:$BUILD_NUMBER" 
            }
        }
        
        stage('Deploy App') {
            steps {
                script {
                  kubernetesDeploy(configs: "kube/nginx.yml", kubeconfigId: "kube_conf")
                }
            }
        }
    }
}
