pipeline {
  agent any
  environment {
    PATH="/usr/local/bin:$PATH"
  }
  stages {
    // The pipeline will fail it can't find terraform
    stage("Check terraform") {
      steps {
        sh "terraform --version"
      }
    }

    stage("Build EC2 infrastructure") {
      steps {
        script {
          // The intent was to build either an ec2 or ecs implementation
          // and have the user choose via Jenkins UI which one to build.
          // In the end, I just did the ec2 target, so it by default.
          String target = "ec2"
          if (env.TARGET?.trim()) {
            target = env.TARGET
          }
          // Run either a terraform apply or destroy based on passed-in value
          String cmd = env.DESTROY.toBoolean() ? "destroy" : "apply"
          // Get user's home public IP so it can be set up for port 22 (ssh)
          // access in the security group
          String homeIP = sh(script: "curl checkip.amazonaws.com",
                             returnStdout: true).trim()
          dir("$env.WORKSPACE/$target") {
              sh """
                  terraform init
                  terraform $cmd -var \"home_public_ip=$homeIP\" --auto-approve
              """
          }
        }
      }
    }
  }
}
