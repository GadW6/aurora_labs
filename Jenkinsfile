pipeline {
    agent any
    options {
        // Keep slim history
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    stages {
        stage('Trigger Python Script') {
            steps {
                sh 'echo "Running script..."'
                sh "python main.py"
            }
        }
    }
    post {
      always {
        // Code to execute always
        echo 'Pipeline completed'
        cleanWs()
      }
    }
}