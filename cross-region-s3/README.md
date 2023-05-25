# Multi region s3 replication

https://aws.amazon.com/getting-started/hands-on/getting-started-with-amazon-s3-multi-region-access-points/

## Description
    In this mini project we created 2 bucket in `eu-west-1` and `eu-west-1` region. 
    I used multi region replication for copy data from one region to other.

#### IAM Role:
    ```
    resource "aws_iam_role" "tf-iam-role-replication-12345678" {
  name = "tf-iam-role-replication-12345678"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "s3.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
  inline_policy {
    name = "tf-iam-role-replication-12345"
    policy = jsonencode({
      "Version" : "2012-10-17"

      "Statement" : [
        {
          "Action" : [
            "s3:ListBucket",
            "s3:GetReplicationConfiguration"
          ],
          "Effect" : "Allow",
          "Resource" : "arn:aws:s3:::us-east-1-bucket-ali",
          "Sid" : ""
        },
        {
          "Action" : [
            "s3:GetObjectVersionTagging",
            "s3:GetObjectVersionForReplication",
            "s3:GetObjectVersionAcl"
          ],
          "Effect" : "Allow",
          "Resource" : "*",
          "Sid" : ""
        },
        {
          "Action" : [
            "s3:ReplicateTags",
            "s3:ReplicateObject",
            "s3:ReplicateDelete"
          ],
          "Effect" : "Allow",
          "Resource" : "*",
          "Sid" : ""
        }
      ]
    })

  }

}
```

##### Used this command for create file and upload multi region
```
dd if=/dev/urandom of=test1.file bs=1M count=10

aws s3 cp test1.file <<Arn of Multi region>>


