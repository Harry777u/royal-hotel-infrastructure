pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'cd terraform && terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'cd terraform && terraform validate'
            }
        }

        stage('Deploy Infrastructure') {
            steps {
                withCredentials([
                    sshUserPrivateKey(
                        credentialsId: 'royal-hotel-ssh-key',
                        keyFileVariable: 'SSH_KEY',
                        usernameVariable: 'SSH_USER'
                    )
                ]) {
                    sh '''
                        export SSH_KEY
                        export SSH_USER
                        ./deploy.sh
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Royal Hotel infrastructure deployment completed successfully.'
        }

        failure {
            echo 'Royal Hotel infrastructure deployment failed.'
        }
    }
}