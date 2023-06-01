# resource "aws_iam_policy" "ssm_policy" {
#   name = "ssm_policy"
#   path = "/"
#   policy = jsondecode({
#     ]
#   })
# }

# resource "aws_iam_role" "ssm_role" {
#   name = "ssm_role"
#   assume_role_policy = jsondecode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action    = "sts:AssumeRole"
#         Effect    = "Allow",
#         Sid       = ""
#         Principal = { Service = "ec2.amazonaws.com" },

#       },
#     ]
#   })
# }

# resource "aws_iam_policy_attachment" "ec2_policy_attachment" {
#   name       = "ec2-profile-ssm"
#   roles      = [aws_iam_role.ssm_role.name]
#   policy_arn = aws_iam_policy.ssm_policy.arn
# }


resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy"
  role = aws_iam_role.test_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"

    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "cloudwatch:PutMetricData",
          "ds:CreateComputer",
          "ds:DescribeDirectories",
          "ec2:DescribeInstanceStatus",
          "logs:*",
          "ssm:*",
          "ec2messages:*"
        ],
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = "iam:CreateServiceLinkedRole",
        Resource = "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM*",
        Condition = {
          "StringLike" : {
            "iam:AWSServiceName" : "ssm.amazonaws.com"
          }
        }
      },
      {
        Effect = "Allow",
        Action = [
          "iam:DeleteServiceLinkedRole",
          "iam:GetServiceLinkedRoleDeletionStatus"
        ],
        Resource = "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM*"
      },
      {
        Effect = "Allow",
        Action = [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ],
        Resource = "*"
      }

    ]
  })
}
resource "aws_iam_role" "test_role" {
  name = "test_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}
