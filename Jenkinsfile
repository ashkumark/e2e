pipeline {

	agent { label 'jenkins-agent' }

	environment {
		uri = '518637836680.dkr.ecr.eu-west-2.amazonaws.com/ashkumarkdocker/docker-e2e-automation'
		registryCredential = '518637836680'
		dockerImage = ''
		HUB_HOST = 'selenium-hub'
	}
	
	stages {
	
		stage('Build Image') {
	       steps {
	           script {
	               dockerImage = docker.build("ashkumarkdocker/docker-e2e-automation")
	           }
	       }
	    }
	    
		// Start docker-compose selenium-hub
		stage('Start docker-compose') {
			steps {
				sh 'docker-compose up -d'
			}
		}
		
		stage('UI Automation - Chrome') {
			steps {		
				sh 'docker-compose run -e BROWSER="chrome" selenium-test'
			}
		}
		
		stage('UI Automation - Firefox') {
			steps {
				sh 'docker-compose run -e BROWSER="firefox" selenium-test'
			}
		}
		
		stage('Docker Teardown') {
			steps {
				/* Tear down docker compose */
				sh 'docker-compose down'
				
				/* Tear down all containers */
				sh 'docker-compose rm -sf'
			}
		}
	}	
}










