pipeline {
  environment {
    registry = "kotulev/spring-app"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent any
  stages {
    stage('copy files') {
      steps {
        sh 'rm -rf s-b-d'  
        sh 'git clone https://github.com/KotulevD/s-b-d.git'
        sh 'cp s-b-d/Dockerfile .'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    
    stage('Test') {
      steps{
        sh 'docker container run -d --name spring-boot-$BUILD_NUMBER -p 8090:8080 --rm $registry:$BUILD_NUMBER'
        sh 'sleep 30'
        sh 'curl 172.17.0.1:8090'
        sh 'docker container stop spring-boot-$BUILD_NUMBER'
      }
    }
    
    /*stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    */
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
}
