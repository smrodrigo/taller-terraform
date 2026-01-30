pipeline {
    agent any

	environment {
        INFRACOST_API_KEY = credentials('INFRACOST_API_KEY')
        AWS_ACCESS_KEY_ID = credentials('aws-credentials')
        AWS_SECRET_ACCESS_KEY = credentials('aws-credentials')
        AWS_REGION = 'eu-south-2'
    }
	
    parameters {  
        choice(name: 'TARGET_ACTION', choices: ['apply', 'destroy'], description: 'Select the action')  
    }  
    
    stages {
        stage('Calculating Cost') {
            steps {
                //git branch: 'main', credentialsId: '<CREDS>', url: 'https://github.com/sumeetninawe/tf-tuts'
                 echo "Running tests in the ${params.TARGET_ACTION} environment."  
				sh "infracost configure set api_key ${INFRACOST_API_KEY}"
                sh "infracost breakdown --path . --format json --out-file infracost-base.json"                
				//sh "infracost output --path infracost.json --format table --out-file infracost-base.md"
				sh "cat infracost-base.json"
            }
        }
		
        stage('Checkout Repository') {
            steps {
                script {
                    sh 'ls -lah'  // Verify repository checkout
                }
            }
        }

        stage('AWS CLI Check') {
            steps {
                sh 'aws sts get-caller-identity' // Verifica la identidad IAM
                sh 'aws s3 ls' // Ejemplo: listar S3
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
		
	//	stage('Terraform Action') {
    //        steps {
    //            dir('terraform') {
     //               script {
     //                   if (params.ACTION == 'apply') {
     //                       sh 'terraform apply -auto-approve tfplan'
    //                    } else if (params.ACTION == 'destroy') {
     //                       sh 'terraform destroy -auto-approve'
     //                   }
     //               }
     //           }
     //       }
     //   }
        
    }
}
