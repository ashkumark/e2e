pipeline {
  agent { label 'jenkins-agent' }

  environment {
    uri = '518637836680.dkr.ecr.eu-west-2.amazonaws.com/ashkumarkdocker/docker-e2e-automation'
    registryCredential = '518637836680'
    dockerImage = ''
  }


  stages {  
    // Start docker-compose with 1 instance of Chrome and 1 instance of firefox
      stage('Start docker-compose') {
        steps {
            sh 'docker-compose up -d --scale chrome=1 --scale firefox=1'
        }
      }
  
    stage('Build Image') {
      steps {
        script {
          dockerImage = docker.build("ashkumarkdocker/docker-e2e-automation")
        }
      }
    }

    stage('Run Tests in Parallel') {
      parallel {
        stage('API Automation') {
          agent {
            docker {
              image 'ashkumarkdocker/docker-e2e-automation'
              args '-v $HOME/.m2:/root/.m2'
            }
          }
          steps {
            sh 'mvn test -Dcucumber.filter.tags="@API"'
          }
        }


      stage('UI Automation - Chrome') {
        agent {
          docker {
            image 'ashkumarkdocker/docker-e2e-automation'
              args '-v $HOME/.m2:/root/.m2'
            }
        }
        steps {
            sh 'mvn test -Dcucumber.filter.tags="@UI" -DHUB_HOST="selenium-hub" -DBROWSER="chrome"'
        }
      }
      stage('UI Automation - Firefox') {
          agent {
            docker {
              image 'ashkumarkdocker/docker-e2e-automation'
              args '-v $HOME/.m2:/root/.m2'
            }
          }
        steps {
            sh 'mvn test -Dcucumber.filter.tags="@UI" -DHUB_HOST="selenium-hub" -DBROWSER="firefox"'
        }
      }
      

      }
    }


 	stage('Docker Teardown') {
 	
 	  steps {
          /* Tear down docker compose */
          sh 'docker-compose down'
          /* Delete the image which got created earlier */
          sh 'docker rmi ashkumarkdocker/docker-e2e-automation -f'
        }

    }
   }
 }