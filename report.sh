#!bin/bash
aws-describe-instances   #Details of the instance
# aws ec2 describe-subnets   #Details of the subnets
# aws ec2 describe-instances --instance-id i-06de2e63e4b57f1a8\
#   --query 'Reservations[*].Instances[*].[InstanceId,ImageId,Tags[*]]' \
#   --output text         # Details of instanceId, ImageId and Tags
#   #Details of InstanceId and Name of running instances
#   aws ec2 describe-instances --filters 'Name=instance-state-name,Values=running' --query 'Reservations[].Instances[].{Name:Tags[?Key==`Name`].Value | [0],InstanceId:InstanceId}' --output table 
#  #Details of InstanceId and Name of stopped instances
#  aws ec2 describe-instances --filters 'Name=instance-state-name,Values=stopped' --query 'Reservations[].Instances[].{Name:Tags[?Key==`Name`].Value | [0],InstanceId:InstanceId}' --output table
#  #Details of ram
#  aws ec2 describe-instances --instance-ids <instance-id> --query 'Reservations[].Instances[].MemoryInfo.SizeInMiB' --output text
# #AZ Details
#  aws ec2 describe-instances --instance-ids i-06de2e63e4b57f1a8 --query 'Reservations[*].Instances[*].[InstanceId,InstanceType,Placement.AvailabilityZone]' --output text
# #Instance Details running or stopped 
#  aws ec2 describe-instances --filters Name=instance-state-name,Values=running --query "Reservations[*].Instances[*].[InstanceId,InstanceType,PrivateIpAddress,PublicIpAddress,State.Name,Placement.AvailabilityZone]"
# #Running processes
# aws ec2 describe-instances --instance-ids i-06de2e63e4b57f1a8 --query "Reservations[*].Instances[*].RunningProcesses[].ProcessName" --output text | wc -l
# #Details of the AZ, instances, and name
# aws ec2 describe-instances \
#     --filters Name=tag-key,Values=Name \
#     --query 'Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value}' \
#     --output table

# #to list all installed packages on Ubuntu
# apt list --installed

# #The following command filters the list to only your t2.micro instances and outputs only the InstanceId values for each match.
#  aws ec2 describe-instances --filters "Name=instance-type,Values=t2.micro" --query "Reservations[].Instances[].InstanceId"

#To publish the result in ubuntu
# - name: Publish Test Results
#   uses: EnricoMi/publish-unit-test-result-action@v2
#   if: always()
#   with:
#     files: |
#       test-results/**/*.xml
#       test-results/**/*.trx