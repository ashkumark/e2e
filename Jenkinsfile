pipeline {

	agent { label 'jenkins-agent' }

	environment {
		uri = '518637836680.dkr.ecr.eu-west-2.amazonaws.com/ashkumarkdocker/docker-e2e-automation'
		registryCredential = '518637836680'
		dockerImage = ''
		//HUB_HOST = 'selenium-hub'
	}
	
	stages {
	
		stage('Build Image') {
	       steps {
	           script {
	               dockerImage = docker.build("docker-e2e-automation:latest")
	           }
	       }
	    }
	    
		// Start docker-compose selenium-hub
		stage('Start Docker Compose') {
			steps {
				sh 'docker-compose up -d'
			}
		}
		
	/*	stage('API Automation') {
			steps {		
				sh 'docker-compose run -e TYPE="@API" api-test'
			}
			post {
			    always {
    			    publishHTML (target : [
    			         allowMissing: false,
						 alwaysLinkToLastBuild: true,
						 keepAll: true,
						 reportDir: 'reports',
						 reportFiles: 'api-test-index.html',
						 reportName: 'Automation Reports Name',
						 reportTitles: 'Automation Report Title'])
    			}
			}
		}
	*/
		
		stage('UI Automation - Chrome') {
			steps {		
				sh 'docker-compose run -e TYPE="@UI" -e BROWSER="chrome" selenium-test '
			}
			post {
			    always {
    			    publishHTML (target : [
    			         allowMissing: false,
						 alwaysLinkToLastBuild: true,
						 keepAll: true,
						 reportDir: './reports',
						 reportFiles: 'ui-test-index.html',
						 reportName: 'Automation Reports Name',
						 reportTitles: 'Automation Report Title'])
    			}
			}
		}
	/*	
		stage('UI Automation - Firefox') {
			steps {
				sh 'docker-compose run -e TYPE="@UI" -e BROWSER="firefox" selenium-test'
			}
		}
	*/	
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










