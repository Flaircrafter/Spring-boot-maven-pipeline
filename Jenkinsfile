pipeline {
    agent any

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
        
        stage ('Creating Container Image') {
            steps {
                sh 'docker build -t tomcat-demo:${BUILD_NUMBER} .'
            }
        }
    }
}
