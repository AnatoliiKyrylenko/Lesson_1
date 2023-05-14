#/bin/bash
# Set Instance region 
aws configure set default.region eu-central-1
# Create image in current region
aws ec2 create-image --instance-id i-xxxxxxxxxxxxxx --name "image_name" --no-reboot
# Wait 5 minutes
sleep 5m
# Set different region 
aws configure set default.region eu-west-3
# Get Image Id from Name (should already be)
AMIOld=$(aws ec2 describe-images --filters "Name=name,Values=image_name" --query 'Images[*].[ImageId]' --output text)
# Deregister old image in another region
aws ec2 deregister-image --image-id $AMIOld
# Set Instance region
aws configure set default.region eu-central-1
# Get Image Id from Name
AMINew=$(aws ec2 describe-images --filters "Name=name,Values=image_name" --query 'Images[*].[ImageId]' --output text)
# Copy Image to another region
aws ec2 copy-image --source-image-id $AMINew --source-region eu-central-1 --region eu-west-3 --name "image_name"
# Wait 5 minutes
sleep 5m
# Deregister image in instance region
aws ec2 deregister-image --image-id $AMINew