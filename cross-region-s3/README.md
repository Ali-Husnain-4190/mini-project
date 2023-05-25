# Multi region s3 replication

https://aws.amazon.com/getting-started/hands-on/getting-started-with-amazon-s3-multi-region-access-points/

## Description
    In this mini project we created 2 bucket in `eu-west-1` and `eu-west-1` region. 
    I used multi region replication for copy data from one region to other.


##### Used this command for create file and upload multi region
dd if=/dev/urandom of=test1.file bs=1M count=10

aws s3 cp test1.file <<Arn of Multi region>>


