pipeline {
    agent any
    
    tools{
        
        jdk "jdk"
        maven "maven"
        
    }
    environment{
        SCANNER_HOME= tool 'sonar-scanner'
    }

    stages {
        stage('Git Checkout') {
            steps {
               git changelog: false, poll: false, url: 'https://github.com/17J/secretsanta-generator.git'
            }
        }
        stage('Trviy Repo Scan') {
            steps {
               sh 'trivy repo --format table -o repo-report.html https://github.com/17J/secretsanta-generator.git '
            }
        }
        stage('Compile') {
            steps {
               sh 'mvn compile'
            }
        }
        stage('Code Analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                    
                    sh ''' $SCANNER_HOME/bin/sonar-scanner  -Dsonar.projectName=santa \
                           -Dsonar.java.binaries=.\
                           -Dsonar.projectKey=santa '''
   
                    }
            }
        }
        stage('Quality Gate') {
            steps {
                script{

                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
               }
            }
        }
        stage('Build') {
            steps {
                sh 'mvn package'
            }
        }
        stage('Build Docker Image and Tag') {
            steps {
                script{
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                     sh 'docker build -t secretsanta .'
                     sh 'docker tag secretsanta 17rj/secretsanta_generator'
                   } 
                }
            }
        }
        stage('Image Scan') {
            steps {
                sh 'trivy image --format table -o docker-image-report.html 17rj/secretsanta_generator'
            }
        }
        stage('Docker Image Push') {
            steps {
                script{
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                    
                     sh 'docker push 17rj/secretsanta_generator'
                   } 
                }
            }
        }
        stage('Docker Deploy') {
            steps {
                script{
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                     
                     sh 'docker run -d -p 8085:8080 --name secretsantaimage  17rj/secretsanta_generator'
                   } 
                }
            }
        }
    }
}
