pipeline {
    agent any
    tools{
        maven "maven"
        jdk "jdk"
    }
    
    environment{
        SCANNER_HOME= tool 'sonar'
    }

    stages {
        stage('Git Checkout') {
            steps {
                echo 'Git Checkout'
                git branch: 'devops', changelog: false, poll: false, url: 'https://github.com/17J/secretsanta-generator.git'
                
            }
        }
        stage('Trivy Repo Scan') {
            steps {
               
                sh 'trivy repo --format table -o repo-report.html https://github.com/17J/secretsanta-generator.git'
                
            }
        }
        stage('Compile') {
            steps {
               
                sh 'mvn compile'
                
            }
        }
        stage('Test') {
            steps {
               
                sh 'mvn test -DskipTests=true'
                
            }
        }
        stage('SonarQube Code Analysis') {
            steps {
               withSonarQubeEnv('sonar') {
                  sh ''' $SCANNER_HOME/bin/sonar-scanner  -Dsonar.projectName=secretsanta \
                           -Dsonar.java.binaries=.\
                           -Dsonar.projectKey=secretsanta '''
                  }
                
                
            }
        }
        stage('Quality Gate') {
            steps {
               script{
                   
                   waitForQualityGate abortPipeline: false, credentialsId: 'sonarqube-cred'
               }
                
                
            }
        }
        stage('Build') {
            steps {
                sh 'mvn package -DskipTests=true'
                
            }
        }
        stage('Docker Image Build And Tagging') {
            steps {
                script{
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                         sh 'docker build -t demosanta .'
                         sh 'docker tag demosanta 17rj/secretsantagifting:latest'
                   }
                }
                
            }
        }
        stage('Trivy Image Scan') {
            steps {
               
                sh 'trivy image --format table -o docker-image-report.html 17rj/secretsantagifting:latest'
                
            }
        }
        stage('Image Push to Docker Hub') {
            steps {
                script{
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                         sh 'docker push 17rj/secretsantagifting:latest'
                   }
                }
                
            }
        }
        stage('K8s Deploy') {
            steps {
                withKubeConfig(caCertificate: '', clusterName: ' demo-eks17', contextName: '', credentialsId: 'kube-cred', namespace: 'webapps', restrictKubeConfigAccess: false, serverUrl: 'https://746713E5F1AAFA670294CBA58DC6246C.gr7.us-east-1.eks.amazonaws.com') {
                   sh 'kubectl apply -f deployment-service.yaml'
                   sleep 60
                }
                
            }
        }
        stage('Verified Deploymment') {
            steps {
                withKubeConfig(caCertificate: '', clusterName: ' demo-eks17', contextName: '', credentialsId: 'kube-cred', namespace: 'webapps', restrictKubeConfigAccess: false, serverUrl: 'https://746713E5F1AAFA670294CBA58DC6246C.gr7.us-east-1.eks.amazonaws.com') {
                   sh 'kubectl get pods -n webapps'
                   sh 'kubectl get svc -n webapps'
                }
                
            }
        }
        
    }
    post {
    // This block always executes after the pipeline finishes
    always {
      echo 'Pipeline execution completed.'
    }

    // Perform actions only when the pipeline fails
    failure {
      emailaddress '17rahuljoshi@gmail.com',  // Replace with your email address
        body: "Pipeline '${env.JOB_NAME}' (#${env.BUILD_NUMBER}) failed!\nBuild logs: ${env.BUILD_URL}console",
        subject: "Pipeline Failure Notification"
    }
  }
}
