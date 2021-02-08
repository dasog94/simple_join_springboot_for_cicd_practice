pipeline{
    agent {
        node {
            label 'master'
        }
    }
        stages{
            stage ('Git Pull') {
                steps {
                    git 'https://github.com/dasog94/simple_join_springboot_for_cicd_practice.git'
                }
            }

            stage ('Prepare') {
                steps {
                    sh 'chmod +x gradlew'
                }
            }

            stage('Gradle Build'){
                steps{
                    sh './gradlew build'
                }
                post{
                    success{
                        slackSend channel:'#cicd', color:'good',message:"The pipeline ${currentBuild.fullDisplayName} stage Build JAR successfully."
                    }
                    failure {
                        slackSend channel: '#cicd', color: 'danger', message: "The pipeline ${currentBuild.fullDisplayName} stage Build JAR failed."
                    }
                }
            }

            stage ('Move jar') {
                steps{
                    sh 'rm -f *.jar'
                    sh '''cd build/libs/
                        mv *.jar ~/workspace/cicd-jenkins-project-pipeline/'''
                }
            }

            stage('Deploy'){
                steps {
                    step([$class: 'AWSCodeDeployPublisher', applicationName: 'cicd-app', awsAccessKey: '',
                    awsSecretKey: '', credentials: 'awsAccessKey', deploymentConfig: 'cicd-config', deploymentGroupAppspec: false,
                    deploymentGroupName: 'cicd-group', excludes: '', iamRoleArn: '', includes: '*.jar, appspec.yml, Scripts/*', proxyHost: '', proxyPort: 0,
                    region: 'ap-northeast-2', s3bucket: 'jenkins-test-buc', s3prefix: '', subdirectory: '', versionFileName: '', waitForCompletion: false])
                }
                post {
                    success {
                        slackSend channel: '#cicd', color: 'good', message: "The pipeline ${currentBuild.fullDisplayName} stage Deploy successfully."
                    }
                    failure {
                        slackSend channel: '#cicd', color: 'danger', message: "The pipeline ${currentBuild.fullDisplayName} stage Deploy failed."
                    }
                }
            }
        }
}