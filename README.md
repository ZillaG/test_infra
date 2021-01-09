# Appcues CID Engineering Exercise #
## Requirements ##
- Fork our Github repo and use it to create a pipeline that deploys it to AWS EC2 when
PRs are merged to the default branch. You can use AWS’ free tier if you don’t have an
account.
- Show that the service returns data over HTTP

## Features ##
- Run the tests in the project and gate deployment on success.
- Implement auto-scaling for your service based on system load

## Deliverables ##
- Credentials for AWS and anything else needed to review your functional implementation. It’s considered complete if all of the Basic items and two of the Enhancements items are implemented and working.
- A brief document explaining why you built it the way you did. Include details of how you approached the problem as well as your choice of other tools used (if any).
- A postmortem summarizing your findings. Did it go smoothly? Any surprises or lessons learned? What high level approach would you take to enhance the project to have all configuration as code? Should we implement a production-ready version of what you built, or would you do things differently if it was going to production and you had more time?

## Prerequisites ##
### Set up 2 ssh keys, one for Github, the other for AWS ###
Keys will be provided per deliverable
```
- ~/.ssh/cf-github-rsa (ssh access to Github files)
- ~/.ssh/test-user-rsa (ssh access to AWS EC2)
```

### Install Terraform ###
NOTE: Giving a full tutorial of Terraform is beyond the scope of the exercise. Note the Terraform scripts use v0.14.4.
- Please see https://www.terraform.io/downloads.html

### Install AWS CLI ###
NOTE: Giving a full tutorial of AWS CLI is beyond the scope of the exercise. At the moment of the writing of the document, version 1 is preferred. Keys will be provided per deliverable
- Please see https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html
- Ensure you have the following entries in your `~/.aws/credentials` and `~/.aws/config` files
```
~/.aws/credentials
[test_user]
aws_access_key_id=replace_with_provided_key
aws_secret_access_key=replace_with_provided_key

~/.aws/config
[profile test_user]
region=us-east-1
output=json
```

### Setup ssh key ###
- Put the provided ssh private key in a `~/.ssh/test-user-rsa` file and chmod the file to `0400` 
- Add key to key chain with `ssh-add -K ~/.ssh/test-user-rsa`
- Same for `cf-github-rsa`

### Install and setup Jenkins locally ###
NOTE: Giving a full tutorial of Jenkins is beyond the scope of the exercise.
- Install Jenkins on your local machine. Please see https://www.jenkins.io/download/. 
- Once installed, start Jenkins (should be `localhost:8080`)
- Once started, setup an "SSH username and private key" credential in "Manage Jenkins->Manage Credentials" and and give it an ID of "cf-github-rsa" that will contain the provided private ssh key file assocaited with my public key on my Github repo.
- Also set up an "AWS Credentials" credential and call it "test-user-aws" that will contain the provided AWS access and secret keys

## Jenkins job setup ##
### Job to build application ###
Go back to the Jenkins Dashboard and set up a Pipeline job called "app-builder" to build the application with the following Pipeline Definitions:
- Type: Pipeline Script from SCM
- SCM type: Git
- Repository URL: git@github.com:ZillaG/cid-engineer-project.git
- Credentials: (Name of ssh creds setup earlier)
- Branches to build: master
- Script Path: Jenkinsfile
- Unclick "Lightweight checkout"
- Save the job

### Job to deploy the application ###
Setup a Pipeline job called "deploy-sandbox" (exact name) to deploy the applicatin to AWS with the following settings:
- Click "This project is parameterized" and create a "Boolean parameter" named "DESTROY" (all caps), and Description "Destroy infrastructure?"
- Type: Pipeline Script from SCM
- SCM type: Git
- Repository URL: git@github.com:ZillaG/test_infra.git
- Credentials: (Name of ssh creds setup earlier)
- Branches to build: master
- Script Path: Jenkinsfile
- Unclick "Lightweight checkout"
- Save the job

### Run the jobs ###
- Run the "app-builder" job. If all is done correctly, you should see the job run the Jenkinsfile that clones the repo, build and test the applicaiton, create Docker image and push itm to ECR, and call the "deploy-sandbox" job.
- If all goes well for the "deploy-sandbox" job an AWS autoscaling-group infrastructure is build and you'll the following in the Jenkins console.
```
module_ami_id = "ami-123456abcdef"
module_autoscaling_group_id = "tf-asg-123456abcdef"
module_gw_id = "igw-123456abcdef"
module_launch_template_id = "lt-123456abcdef"
module_security_group_id = "sg-123456abcdef"
module_subnet_id = "subnet-123456abcdef"
module_vpc_id = "vpc-123456abcdef"
```

## To test the features ##
### Run the tests in the project and gate deployment on success. ###
- Clone the https://github.com/ZillaG/cid-engineer-project repo
- Modify the test/test.js file so the assert fails (change one of the booleans to false)
- Push changes
- Run the "app-builder" job; it should now fail and not proceed with the rest of the script, i.e., no docker build/push, and no trigger for the deploy job. 

### Implement auto-scaling for your service based on system load ###
Run the following AWS CLI commands. (NOTE: I set up user test_user to only have CLI access, i.e., no console access). 
```
$ export AWS_PROFILE=test_user
$ aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names module_autoscaling_group_id_from_console_output
(Note the "Instances" block and the "InstanceId" attribute (i-xxxxxx) of the 1 instance created)
$ aws ec2 describe-instances --instance-id (InstandId from above)
Note the "PublicDnsName" attribute
Enter the `PublicDnsName` on your browser and you should see "Index response"  
$ ssh ec2-user@PublicDnsName -i ~/.ssh/test-user-rsa  
(NOTE: I setup the security groups only the user's home IP can ssh to it)  
On the node execute "sudo stress --cpu 1 --timeout 300" to stress the 1-core CPU for 5 minutes  
After 5 minutes +/-, issue the above command again to describe the autoscaling group. You should now see 2 instances since it scaled up.  
After 5 minutes +/-, issue the above command again to describe the autoscaling group. You should now see 1 instance since it scaled down.  
```

## Deliverables Details ##
### Credentials ###
- Provided

### Approach ###
I used Git, Jenkins, and Terraform for practical reasons, that is, I either know these tools already (Git & Jenkins) or am currently learning them (Terrform), and took the exercie as an excuse to enhance my knowledge even more, and it has. I chose the auto-scaling group approach to teach myself auto-scaling. In a real production environment, I would've used a load balancer with a target group with the instances, and a Route53 record to point to the load balancer.

### Post mortem ###
Of the 3 tools that I used - Git, Jenkins, and Terraform - I found the Terraform setup to be the most challenging simply because I had the least experience. I can pretty much do what I want with Git and Jenkins (via Jekins pipelines). However my only production experience with the Terraform was setting up a Jenkins blue/green deployment for production (Route53, ALB, listeners, target group, target, VPC, subnet, security groups, etc.), so I built my knowledge on top of that experience. Also, it was my first attempt to build an AWS autoscaling group, so I had to learn how to do that - first creating a launch template, then using that to build the ASG. For production, I would do the following:
- Implement AWS secrets or parameter store to avoid passing around keys
- Use Packer to create the AMIs used to create the EC2s in the ASG (Note: for this exercise I just created the AMI manually, but know how to use Packer.)
- Use a application load balancer that forwards to a target group, and add the EC2s to the target group, and hook up the load balancer to the ASG.
- Create a Route53 route to point to the ALB
- Use certificates used by the ALB and force HTTPS access
- Add monitoring for the application to alert support teams for desired alarms
- Use Kubernetes to build my IaC for any environment, e.g., sandbox, staging, uat, produciton.

## Closing Remarks ##
Please run the deployment job with the "DESTROY" parameter checked to destroy the infrastructure.
