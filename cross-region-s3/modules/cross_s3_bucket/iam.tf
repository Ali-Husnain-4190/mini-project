
resource "aws_iam_role" "s3crr_role_for_us-east-1-bucket-ali" {
  name = "s3crr_role_for_us-east-1-bucket-ali"
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
    name = "s3crr_role_for_us-east-1-bucket-ali"
  }
}

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
