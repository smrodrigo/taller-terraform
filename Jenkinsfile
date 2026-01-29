pipeline {
    agent any

    parameters {  
        choice(name: 'TARGET_ACTION', choices: ['apply', 'destroy'], description: 'Select the action')  
    }  
    
    stages {
        stage('Checkout') {
            steps {
                //git branch: 'main', credentialsId: '<CREDS>', url: 'https://github.com/sumeetninawe/tf-tuts'
                 echo "Running tests in the ${params.TARGET_ACTION} environment."  
            }
        }
        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform apply') {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
        
    }
}
