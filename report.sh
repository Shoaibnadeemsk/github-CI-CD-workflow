 aws ec2 describe-instances   #Details of the instance
 aws ec2 describe-subnets   #Details of the subnets
  aws ec2 describe-instances --instance-id $Instance_Id\
    --query 'Reservations[*].Instances[*].[InstanceId,ImageId,Tags[*]]' \
    --output text         # Details of instanceId, ImageId and Tags
 
 #Details of InstanceId and Name of running instances
 aws ec2 describe-instances --filters 'Name=instance-state-name,Values=running' --query 'Reservations[].Instances[].{Name:Tags[?Key==`Name`].Value | [0],InstanceId:InstanceId}' --output table 
#  #Details of InstanceId and Name of stopped instances
 aws ec2 describe-instances --filters 'Name=instance-state-name,Values=stopped' --query 'Reservations[].Instances[].{Name:Tags[?Key==`Name`].Value | [0],InstanceId:InstanceId}' --output table
#  #Details of ram
 aws ec2 describe-instances --instance-ids i-06474f0e051d3c623 --query 'Reservations[*].Instances[*].[InstanceType, MemoryInfo.SizeInMiB, MemoryInfo.Unit]' --output text
# #AZ Details
 aws ec2 describe-instances --instance-ids $Instance_Id --query 'Reservations[*].Instances[*].[InstanceId,InstanceType,Placement.AvailabilityZone]' --output text
# #Instance Details running or stopped 
 aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --query "Reservations[*].Instances[*].[InstanceId,InstanceType,PrivateIpAddress,PublicIpAddress,State.Name,Placement.AvailabilityZone,RamdiskId]"
# #Running processes
aws ec2 describe-instances --instance-ids i-06474f0e051d3c623 --query "Reservations[*].Instances[*].RunningProcesses[].ProcessName" --output text 
# #Details of the AZ, instances, and name
 aws ec2 describe-instances \
     --filters Name=tag-key,Values=Name \
     --query 'Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value}' \
     --output table

  # ssh ec2-user@"public-ip"'yum list installed | wc -l'



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

#To output the instance details to a file
   # echo -e "$instance_details" > instance_details.txt
   #scp -i instance_details.txt ec2user::/home/

#To retrieve the CPU details
# aws cloudwatch get-metric-statistics --namespace AWS/EC2 --metric-name CPUUtilization  --period 3600 \
# --statistics Maximum --dimensions Name=InstanceId,Value=i-1234567890abcdef0 \
# --start-time 2022-10-18T23:18:00 --end-time 2022-10-19T23:18:00
#aws cloudwatch get-metric-statistics --namespace AWS/EC2 --metric-name CPUUtilization --dimensions Name=InstanceId,Value=<your-instance-id> --start-time $(date -u +%FT%TZ --date '-1 hour') --end-time $(date -u +%FT%TZ) --period 60 --statistics Maximum


#aws cloudwatch get-metric-statistics --namespace AWS/EC2 --metric-name CPUUtilization  --period 3600 --statistics Maximum --dimensions Name=InstanceId,Value="$Instance_Id"  --start-time 2022-10-18T23:18:00 --end-time 2022-10-19T23:18:00

#CPUUtilization
#$(aws cloudwatch get-metric-statistics --namespace AWS/EC2 --metric-name CPUUtilization --dimensions Name=InstanceId,Value="$instance_id" --start-time $(date +%s -d '5 minutes ago') --end-time $(date +%s) --period 300 --statistics Average --query 'Datapoints[0].Average')

#RAM 
#$(aws cloudwatch get-metric-statistics --namespace AWS/EC2 --metric-name MemoryUtilization --dimensions Name=InstanceId,Value="$instance_id" --start-time $(date +%s -d '5 minutes ago') --end-time $(date +%s) --period 300 --statistics Average --query 'Datapoints[0].Average')

 #processes
  #$(ssh ec2-user@"$public_ip" 'ps aux | wc -l')
#new_tools
  #$(ssh ec2-user@"$public_ip" 'yum list installed | wc -l')

#aws cloudwatch get-metric-statistics --namespace AWS/EC2 --metric-name MemoryUtilization --dimensions Name=InstanceId,Value="$instance_id" --start-time $(date +%s -d '5 minutes ago') --end-time $(date +%s) --period 300 --statistics Average --query 'Datapoints[0].Average'
# aws cloudwatch get-metric-statistics --namespace AWS/EC2 --metric-name MemoryUtilization  --period 3600 \
#            --statistics Maximum --dimensions Name=InstanceId,Value=i-06474f0e051d3c623 \
#            --start-time 2023-03-18T23:18:00 --end-time 2023-03-19T23:22:00

#aws ec2 describe-instance-types --instance-types t2.micro --query 'InstanceTypes[*].[MemoryInfo.SizeInMiB, MemoryInfo.SpeedMHz, MemoryInfo.Type]' --output text
#  - name: Print installed software
#   run: |
#     INSTANCE_INFO=$(aws ec2 describe-instances --instance-ids <instance-id> --query 'Reservations[*].Instances[*].{ID:InstanceId,Name:Tags[?Key==`Name`]|[0].Value,Software:BlockDeviceMappings[*].Ebs.VolumeId}')
#     echo "${INSTANCE_INFO}"
#aws ec2 describe-instances --instance-ids i-036e1249186882ece --query 'Reservations[*].Instances[*].{ID:InstanceId,Name:Tags[?Key==`Name`]|[0].Value,Software:BlockDeviceMappings[*].Ebs.VolumeId}'
#aws ssm get-inventory --instance-id <instance-id> --query "Entities[*].Data.Applications[?Name=='httpd'].Version | [0]" --output text
#aws ssm describe-instance-information --instance-information-filter-list "key=PingStatus,value=Online" --query "InstanceInformationList[0].InstanceId" --output text | xargs aws ssm list-inventory-entries --instance-id | jq '.Entries[] | select(.TypeName == "AWS:Application") | {Name: .Name, Version: .Version}'

#ssh -i ./GA_Example.pem ec2-user@3.110.184.42