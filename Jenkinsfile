pipeline {
  agent { label 'jenkins-agent' }

  environment {
    uri = '518637836680.dkr.ecr.eu-west-2.amazonaws.com/ashkumarkdocker/docker-e2e-automation'
    registryCredential = '518637836680'
    dockerImage = ''
    HUB_HOST = 'selenium-hub'
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
   
        stage('API Automation') {
          agent {
             //label "API Automation"
            docker {
              image 'ashkumarkdocker/docker-e2e-automation'
               reuseNode true
              args '-v $HOME/.m2:/root/.m2'
            }
          }
          steps {
            sh 'mvn test -Dcucumber.filter.tags="@API"'
          }
        }

 	stage('Run Tests in Parallel') {
      parallel {
      stage('UI Automation - Chrome') {
        agent {
         //label "UI Automation"
          docker {
            image 'ashkumarkdocker/docker-e2e-automation'
             reuseNode true
              args '-v $HOME/.m2:/root/.m2'
            }
        }
        steps {
            sh 'mvn test -Dcucumber.filter.tags="@UI" -DHUB_HOST="selenium-hub" -DBROWSER="chrome"'
        }
      }
      stage('UI Automation - Firefox') {
          agent {
           //label "UI Automation"
            docker {
              image 'ashkumarkdocker/docker-e2e-automation'
               reuseNode true
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