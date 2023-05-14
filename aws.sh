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
