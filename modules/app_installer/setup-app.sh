#!/bin/bash
REPO_NAME="cid-engineer-project"

echo "***********************************************"
echo "Installing updates"
echo "***********************************************"
sudo yum update -y

# The Docker images is in the AMI
echo "***********************************************"
echo "Run the app"
echo "***********************************************"
docker images
docker run -p 80:3000 -d 092258231695.dkr.ecr.us-east-1.amazonaws.com/node-app:latest

#echo "***********************************************"
#echo "Installing NodeJS"
#echo "***********************************************"
#curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
#sudo yum install -y nodejs
#
#echo "***********************************************"
#echo "Installing NodeJS daemonizer"
#echo "***********************************************"
#npm install pm2 -g
#
#echo "***********************************************"
#echo "Installing Git"
#echo "***********************************************"
#sudo yum install -y git
#
#echo "***********************************************"
#echo "Cloning and running app"
#echo "***********************************************"
#git clone https://github.com/ZillaG/$REPO_NAME.git
#if [ -d $REPO_NAME ]; then
#  chown -R ec2-user:ec2-user $REPO_NAME
#  cd $REPO_NAME
#  npm install
#  pm2 start ./bin/www
#  npm test
#else
#  echo "ERROR: $REPO_NAME not cloned"
#fi

