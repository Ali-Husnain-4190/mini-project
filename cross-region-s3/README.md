# Multi region s3 replication

https://aws.amazon.com/getting-started/hands-on/getting-started-with-amazon-s3-multi-region-access-points/

## Description
* Purpose of this project to learn how we can setup module in terraform. and learn 
  how  can we copy data from on region to multiple region. 
1) We created two bucket one in us-east-1 and second one is in us-east-2. After that  
   We created multi region access point and configure s3 replication.
2) for testing create 1 file in us-east-1 region and upload to Multi region account point using below commnad
```
dd if=/dev/urandom of=test1.file bs=1M count=10

aws s3 cp test1.file <<Arn of Multi region>>
```



