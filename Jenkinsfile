pipeline {
    agent any

	environment {
        INFRACOST_API_KEY = credentials('INFRACOST_API_KEY')
        AWS_REGION = 'us-east-1'
    }
	
    parameters {  
        choice(name: 'TARGET_ACTION', choices: ['apply', 'destroy'], description: 'Select the action')  
    }  
    
    stages {
        stage('Calculating Cost') {
            steps {
                echo "Running Infracost to calculate cost"  
				sh "infracost configure set api_key ${INFRACOST_API_KEY}"
                sh "infracost breakdown --path . --format table --out-file infracost-base.md"
				sh "cat infracost-base.json"
            }
        }
		
        stage('AWS CLI Check') {
            steps {			
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                    credentialsId: 'dev_user_aws_cli']]) 
                    {
                        script {
    						sh 'aws sts get-caller-identity' // Verifica la identidad IAM
    						sh 'aws s3 ls' // Ejemplo: listar S3
                        }
                }
            }
        }
        
        stage('Validate Terraform Installation') {
            steps {
                script {
                    sh 'terraform --version'  // Check Terraform version
					sh 'terraform workspace show'
					sh 'terraform workspace list'
                }
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }
		
		stage('Terraform Action') {
            steps {
                dir('terraform') {
                    script {
                        if (params.TARGET_ACTION == 'apply') {
                            sh 'terraform apply -auto-approve tfplan'
                        } else if (params.TARGET_ACTION == 'destroy') {
                            sh 'terraform destroy -auto-approve'
                        }
                    }
                }
            }
        }
    }
	post {
        always {
            echo 'One way or another, I have finished'            
        }
        success {
            echo 'I succeeded!'
        }
        failure {
            echo 'I failed :('
			cleanWs()
        }
    }
}
