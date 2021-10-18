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
		
	/*	stage('UI Automation - Chrome') {
			steps {		
				sh 'docker-compose run -e TYPE="@UI" -e BROWSER="chrome" ui-test-service'
				
				publishHTML (
    			    	target : [
    			         allowMissing: false,
						 alwaysLinkToLastBuild: false,
						 keepAll: true,
						 reportDir: '/home/ubuntu/workspace/pipeline-demo/reports/cucumber-html-report',
						 reportFiles: 'regression-tests.html',
						 reportName: 'Automation Reports'])
			}
			
		}
	
	*/
	/*	
		stage('UI Automation - Firefox') {
			steps {
				sh 'docker-compose run -e TYPE="@UI" -e BROWSER="firefox" selenium-test'
			}
		}
	*/	
	
	stage('UI Tests'){	
       parallel {      
	  		stage('UI Automation - Chrome') {
	        steps {
	
	           sh 'docker-compose run -e TYPE="@UI" -e BROWSER="chrome" ui-test-service'
	                
	        }
	      }
	
	      stage('UI Automation - Firefox') {
	        steps {
	
	         sh 'docker-compose run -e TYPE="@UI" -e BROWSER="firefox" ui-test-service'
	
	             /*   publishHTML (target: [
	                    allowMissing: false,
	                    alwaysLinkToLastBuild: false,
	                    includes: '',
	                    keepAll: true,
	                    reportDir: '/home/ubuntu/workspace/pipeline-demo/reports/cucumber-html-report',
						 reportFiles: 'regression-tests.html',
						 reportName: 'Automation Reports',
						  reportTitles: 'Firefox'
	                ])
				*/
	        }
	      }       
       }
       
       post {
    		always {
		       cucumber buildStatus: 'UNSTABLE',
                reportTitle: 'My report',
                fileIncludePattern: 'cucumber.json',
                jsonReportDirectory: '/docker-jenkins-test/target',
                trendsLimit: 100,
                sortingMethod: 'ALPHABETICAL',
                classifications: [
                    [
                        'key': 'Browser',
                        'value': 'Firefox & Chrome'
                    ]
                ]
   			 }
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










