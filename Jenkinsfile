pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'cd terraform && terraform validate'
            }
        }

        stage('Deploy Infrastructure') {
            steps {
                sh './deploy.sh'
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