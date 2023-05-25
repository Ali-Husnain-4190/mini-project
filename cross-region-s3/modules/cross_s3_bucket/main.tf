provider "aws" {
  region = "us-east-1"
  alias  = "east"
}
resource "aws_s3_bucket" "first_bucket" {
  bucket = var.first_bucket
  tags   = var.tags
  #   versioning {
  #     enabled = true
  #   }
  # acl = "private"
}
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.first_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_ownership_controls" "first_control" {
  bucket = aws_s3_bucket.first_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "first-access" {
  bucket = aws_s3_bucket.first_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "first-acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.first_control,
    aws_s3_bucket_public_access_block.first-access,
  ]

  bucket = aws_s3_bucket.first_bucket.id
  acl    = "public-read"
}
resource "aws_s3_bucket_policy" "public_read_access-first" {
  bucket     = aws_s3_bucket.first_bucket.id
  depends_on = [aws_s3_bucket.first_bucket]
  policy     = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
	  "Principal": "*",
      "Action": [ "*" ],
      "Resource": [
      "${aws_s3_bucket.first_bucket.arn}",
      "${aws_s3_bucket.first_bucket.arn}/*"
      ],
       "Condition": {
            "StringEquals" : { "s3:DataAccessPointArn" : "${aws_s3control_multi_region_access_point.example.yearn}"}
        }
    }
  ]
}
EOF
}


provider "aws" {
  region = "us-east-2"
  alias  = "secondary_region"
}
resource "aws_s3_bucket" "second_bucket" {
  provider = aws.secondary_region

  bucket = var.second_bucket

}
resource "aws_s3control_multi_region_access_point" "example" {
  details {
    name = "mrap"

    region {
      bucket = aws_s3_bucket.first_bucket.id
    }

    region {
      bucket = aws_s3_bucket.second_bucket.id
    }
  }
}
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
resource "aws_iam_role" "replication" {
  name               = "tf-iam-role-replication-12345"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "replication" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket",
    ]

    resources = [aws_s3_bucket.first_bucket.arn]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
    ]

    resources = ["${aws_s3_bucket.first_bucket.arn}/*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
    ]

    resources = ["${aws_s3_bucket.second_bucket.arn}/*"]
  }
}
resource "aws_iam_policy" "replication" {
  name   = "tf-iam-role-policy-replication-12345"
  policy = data.aws_iam_policy_document.replication.json
}

resource "aws_iam_role_policy_attachment" "replication" {
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication.arn
}
resource "aws_s3_bucket_replication_configuration" "replication" {
  # provider = aws.central
  # Must have bucket versioning enabled first
  # depends_on = [aws_s3_bucket_versioning.source]

  role   = aws_iam_role.replication.arn
  bucket = aws_s3_bucket.first_bucket.id

  rule {
    id = "foobar"

    # filter {
    #   prefix = "foo"
    # }

    status = "Enabled"

    destination {
      bucket        = aws_s3_bucket.second_bucket.arn
      storage_class = "STANDARD"
    }
  }
}
