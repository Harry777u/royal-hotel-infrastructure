pipeline {
    agent any

    stages {
        stage('Check Tools') {
            steps {
                sh 'terraform version'
                sh 'ansible --version'
                sh 'git --version'
                sh 'aws --version'
            }
        }
    }
}