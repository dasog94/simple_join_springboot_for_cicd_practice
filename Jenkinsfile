pipeline{
    agent {
        node {
            label 'master'
        }
//     agent any

    }
        stages{
            stage ('Git Progress') {
                steps {
                    git 'https://github.com/dasog94/simple_join_springboot_for_cicd_practice.git'
                }

            }
            stage('Gradle Build'){
                steps{
                    sh 'chmod +x gradlew'
                    sh './gradlew build --warning-mode all'
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
            stage('After Build'){
                steps{
                    sh 'rm -f *.jar'
                    sh '''cd build/libs/
                        mv *.jar ~/workspace/cicd-test2/'''
                }
            }
            stage('Deploy'){
                steps {
                    step([$class: 'AWSCodeDeployPublisher', applicationName: 'cicd-app', awsAccessKey: '', awsSecretKey: '', credentials: 'awsAccessKey', deploymentConfig: 'cicd-config', deploymentGroupAppspec: false, deploymentGroupName: 'cicd-group', excludes: '', iamRoleArn: '', includes: '*.jar, appspec.yml, Scripts/*', proxyHost: '', proxyPort: 0, region: 'ap-northeast-2', s3bucket: 'jenkins-test-buc', s3prefix: '', subdirectory: '', versionFileName: '', waitForCompletion: false])
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