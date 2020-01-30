#!groovy

@Library('slackNotifications-shared-library@master') _

pipeline {
    agent any
    tools {
        maven 'M2'
        jdk 'JDK'
        nodejs 'NODEJS'
    }
    
    // def apigeeUsername = "pratysin@gmail.com"

    environment {
        //getting the current stable/deployed revision...this is used in undeloy.sh in case of failure...
        stable_revision = bat(script: 'curl -H "Authorization: Basic $base64encoded" "https://api.enterprise.apigee.com/v1/organizations/pratyushsingh-eval/apis/forecastweatherapi/deployments" | jq -r ".environment[0].revision[0].name"', returnStdout: true).trim()
    }

    stages {
        stage('Initial-Checks') {
            steps {
                sendNotifications 'STARTED'
                bat "npm -v"
                bat "mvn -v"
             //   echo "$apigeeUsername"
                echo "Stable Revision: ${env.stable_revision}"
            }
        }		
        stage('Policy-Code Analysis') {
            steps {
                bat "npm install -g apigeelint"
                bat "apigeelint -s C:/Users/Pratyush/Downloads/weatherapi-master/weatherapi-master/samples/forecastweatherapi-recommended/src/gateway/forecastweatherapi/apiproxy/ -f codeframe.js"
            }
        }
  /*      stage('Unit-Test-With-Coverage') {
            steps {
               script {
                    try {
                        bat "npm install"
                        bat "npm test test/unit/*.js"
                        bat "npm run coverage test/unit/*.js"
                   } catch (e) {
                        throw e
                    } finally {
                        bat "cd coverage && cp cobertura-coverage.xml $WORKSPACE"
                        step([$class: 'CoberturaPublisher', coberturaReportFile: 'cobertura-coverage.xml'])
                    }
                }
            }
        } */
        /*stage('Promotion') {
            steps {
                timeout(time: 2, unit: 'DAYS') {
                    input 'Do you want to Approve?'
                }
            }
        }*/
        stage('Deploy to Production') {
            steps {
                 //deploy using maven plugin
                 
                 // deploy only proxy and deploy both proxy and config based on edge.js update
                //bat "sh && sh deploy.sh"
                bat "mvn -f C:/Users/Pratyush/Downloads/weatherapi-master/weatherapi-master/samples/forecastweatherapi-recommended/src/gateway/forecastweatherapi/pom.xml install -Pprod -Dusername=pratysin@gmail.com -Dpassword=Qwaszx@123 -Dorg=pratysin-97213-eval -Dapigee.config.options=update"
            }
        }
        stage('Integration Tests') {
            steps {
                script {
                    try {
                        // using credentials.sh to get the client_id and secret of the app..
                        // thought of using them in cucumber oauth feature
                        // bat "sh && sh credentials.sh"
                        bat "cd $WORKSPACE/test/integration && npm install"
                        bat "cd $WORKSPACE/test/integration && npm test"
                    } catch (e) {
                        //if tests fail, I have used an shell script which has 3 APIs to undeploy, delete current revision & deploy previous stable revision
                        // bat "bash undeploy.sh"
                        throw e
                    } finally {
                        // generate cucumber reports in both Test Pass/Fail scenario
                        bat "cd $WORKSPACE/test/integration && copy reports.json $WORKSPACE"
                        cucumber fileIncludePattern: 'reports.json'
                        build job: 'cucumber-report'
                    }
                }
            }
        } 
    }
}

/*
using shared library for slack reporting
    the lib groovy script must be placed in a vars folder in SCM
using build job to call a Freestyle project which sends the Cucumber reports to slack
    currently the cucumberSlackSend channel: 'weatherapi', json: '$WORKSPACE/reports.json' 
        option doesnt send the reports to Slack
*/
