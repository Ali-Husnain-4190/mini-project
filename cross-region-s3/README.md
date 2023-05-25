# Multi region s3 replication

https://aws.amazon.com/getting-started/hands-on/getting-started-with-amazon-s3-multi-region-access-points/

## Description

* Purpose of this project to learn how we can setup module in terraform. and learn 
  how  can we copy data from on region to multiple region. 
1) We created two bucket one in us-east-1 and second one is in us-east-2. After that  
   We created multi region access point and configure s3 replication.
2) for testing create 1 file in us-east-1 region and upload to Multi region account point using below commnad
```
    In this mini project we created 2 bucket in `eu-west-1` and `eu-west-1` region. 
    I used multi region replication for copy data from one region to other.


##### Used this command for create file and upload multi region
>>>>>>> dc1196e8fa8a373f5602b00804a20affb3c1122a
dd if=/dev/urandom of=test1.file bs=1M count=10s

aws s3 cp test1.file <<Arn of Multi region>>
```



s