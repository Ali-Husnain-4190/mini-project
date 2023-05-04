
resource "aws_iam_role" "event_bridge_role" {
  name = "event_brige_role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "events.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
  inline_policy {
    name = "event_bridge"
    policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "states:StartExecution"
          ],
          "Resource" : [
            "arn:aws:states:us-east-1:160884609839:stateMachine:my-state-machine"
          ]
        }
      ]
    })

  }
}
resource "aws_iam_role" "step_function_role" {
  name = "step_function_role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "states.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      },
    ]

  })
  inline_policy {
    name = "step_function_role_inline"
    policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "xray:PutTraceSegments",
            "xray:PutTelemetryRecords",
            "xray:GetSamplingRules",
            "xray:GetSamplingTargets"
          ],
          "Effect" : "Allow",
          "Resource" : [
            "*"
          ]
        },
        {
          "Action" : [
            "lambda:InvokeFunction"
          ],
          "Effect" : "Allow",
          "Resource" : [
            "arn:aws:lambda:us-east-1:160884609839:function:get_value"
          ]
        },
        {
          "Action" : [
            "lambda:InvokeFunction"
          ],
          "Effect" : "Allow",
          "Resource" : [
            "arn:aws:lambda:us-east-1:160884609839:function:dynamo"
          ]
        },

        {
          "Action" : [
            "lambda:InvokeFunction"
          ],
          "Effect" : "Allow",
          "Resource" : [
            "arn:aws:lambda:us-east-1:160884609839:function:get_stop_instance"
          ]
        }
      ]
      }
    )
  }
}
resource "aws_iam_role" "role_lambda_function" {
  name = "role_lambda"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })
  inline_policy {
    name = "test_policy"

    policy = jsonencode(
      {
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Effect" : "Allow",
            "Action" : [
              "logs:CreateLogGroup",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
            ],
            "Resource" : [
              "*"
            ]
          }
        ]
    })
  }
}

resource "aws_iam_role" "dynamodb-role" {
  name = "dynamodb-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })
  inline_policy {
    name = "dynamodb"

    policy = jsonencode(
      {
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Sid" : "VisualEditor0",
            "Effect" : "Allow",
            "Action" : [
              "dynamodb:DeleteItem",
              "dynamodb:RestoreTableToPointInTime",
              "dynamodb:CreateTableReplica",
              "dynamodb:UpdateContributorInsights",
              "dynamodb:UpdateGlobalTable",
              "dynamodb:CreateBackup",
              "dynamodb:DeleteTable",
              "dynamodb:UpdateTableReplicaAutoScaling",
              "dynamodb:UpdateContinuousBackups",
              "dynamodb:PartiQLInsert",
              "dynamodb:UpdateGlobalTableVersion",
              "dynamodb:CreateGlobalTable",
              "dynamodb:EnableKinesisStreamingDestination",
              "dynamodb:ImportTable",
              "dynamodb:DisableKinesisStreamingDestination",
              "dynamodb:UpdateTimeToLive",
              "dynamodb:BatchWriteItem",
              "dynamodb:PutItem",
              "dynamodb:PartiQLUpdate",
              "dynamodb:StartAwsBackupJob",
              "dynamodb:UpdateItem",
              "dynamodb:DeleteTableReplica",
              "logs:CreateLogGroup",
              "dynamodb:CreateTable",
              "dynamodb:UpdateGlobalTableSettings",
              "dynamodb:RestoreTableFromAwsBackup",
              "dynamodb:RestoreTableFromBackup",
              "dynamodb:ExportTableToPointInTime",
              "dynamodb:DeleteBackup",
              "dynamodb:UpdateTable",
              "dynamodb:PartiQLDelete"
            ],
            "Resource" : [
              "arn:aws:dynamodb:us-east-1:160884609839:table/EC2TF"
            ]
          },
          {
            "Sid" : "VisualEditor1",
            "Effect" : "Allow",
            "Action" : "dynamodb:PurchaseReservedCapacityOfferings",
            "Resource" : "*"
          },
          {
            "Sid" : "VisualEditor2",
            "Effect" : "Allow",
            "Action" : [
              "logs:CreateLogStream",
              "logs:PutLogEvents"
            ],
            "Resource" : "arn:aws:logs:us-east-1:160884609839:log-group:/aws/lambda/dynamo:*"
          }
        ]
      }
    )
  }
}


resource "aws_iam_role" "get_stop_instance" {
  name = "get_stop_instance"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })
  inline_policy {
    name = "dynamodb"

    policy = jsonencode(
      {
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Sid" : "VisualEditor0",
            "Effect" : "Allow",
            "Action" : [
              "ses:CreateReceiptRule",
              "ses:SetIdentityMailFromDomain",
              "ses:DeleteReceiptFilter",
              "ses:VerifyEmailIdentity",
              "ses:CreateReceiptFilter",
              "ses:CreateConfigurationSetTrackingOptions",
              "ses:UpdateAccountSendingEnabled",
              "ses:DeleteConfigurationSetEventDestination",
              "ses:DeleteVerifiedEmailAddress",
              "ses:SendEmail",
              "ses:SendTemplatedEmail",
              "ses:SendCustomVerificationEmail",
              "ses:UpdateTemplate",
              "ses:DeleteConfigurationSetTrackingOptions",
              "ses:UpdateConfigurationSetTrackingOptions",
              "ses:SetIdentityNotificationTopic",
              "ses:SetIdentityDkimEnabled",
              "ses:CreateConfigurationSet",
              "ses:DeleteReceiptRuleSet",
              "ses:CreateTemplate",
              "ses:ReorderReceiptRuleSet",
              "ses:CreateReceiptRuleSet",
              "dynamodb:DescribeReservedCapacity",
              "ses:CreateConfigurationSetEventDestination",
              "ses:SendBulkTemplatedEmail",
              "dynamodb:DescribeEndpoints",
              "ses:SetIdentityFeedbackForwardingEnabled",
              "ses:UpdateConfigurationSetEventDestination",
              "ses:DeleteCustomVerificationEmailTemplate",
              "ses:TestRenderTemplate",
              "dynamodb:PurchaseReservedCapacityOfferings",
              "ses:DeleteReceiptRule",
              "ses:DeleteConfigurationSet",
              "ses:VerifyDomainDkim",
              "ses:VerifyDomainIdentity",
              "ses:CloneReceiptRuleSet",
              "ses:SetIdentityHeadersInNotificationsEnabled",
              "dynamodb:DescribeReservedCapacityOfferings",
              "dynamodb:DescribeLimits",
              "ses:PutConfigurationSetDeliveryOptions",
              "ses:VerifyEmailAddress",
              "ses:UpdateReceiptRule",
              "ses:UpdateConfigurationSetReputationMetricsEnabled",
              "ses:SendRawEmail",
              "ses:SendBounce",
              "ses:UpdateConfigurationSetSendingEnabled",
              "dynamodb:ListStreams",
              "ses:SetActiveReceiptRuleSet",
              "ses:CreateCustomVerificationEmailTemplate",
              "ses:UpdateCustomVerificationEmailTemplate",
              "ses:DeleteTemplate",
              "ses:SetReceiptRulePosition",
              "ses:DeleteIdentity"
            ],
            "Resource" : "*"
          },
          {
            "Sid" : "VisualEditor1",
            "Effect" : "Allow",
            "Action" : [
              "dynamodb:DescribeContributorInsights",
              "dynamodb:RestoreTableToPointInTime",
              "dynamodb:UpdateGlobalTable",
              "dynamodb:DeleteTable",
              "dynamodb:UpdateTableReplicaAutoScaling",
              "dynamodb:DescribeTable",
              "dynamodb:PartiQLInsert",
              "dynamodb:GetItem",
              "dynamodb:DescribeContinuousBackups",
              "dynamodb:DescribeExport",
              "dynamodb:EnableKinesisStreamingDestination",
              "dynamodb:BatchGetItem",
              "dynamodb:DisableKinesisStreamingDestination",
              "dynamodb:UpdateTimeToLive",
              "dynamodb:BatchWriteItem",
              "dynamodb:PutItem",
              "dynamodb:PartiQLUpdate",
              "dynamodb:Scan",
              "dynamodb:StartAwsBackupJob",
              "dynamodb:UpdateItem",
              "logs:CreateLogGroup",
              "dynamodb:UpdateGlobalTableSettings",
              "dynamodb:CreateTable",
              "dynamodb:RestoreTableFromAwsBackup",
              "dynamodb:GetShardIterator",
              "dynamodb:ExportTableToPointInTime",
              "dynamodb:DescribeBackup",
              "dynamodb:UpdateTable",
              "dynamodb:GetRecords",
              "dynamodb:DescribeTableReplicaAutoScaling",
              "dynamodb:DescribeImport",
              "dynamodb:DeleteItem",
              "dynamodb:CreateTableReplica",
              "dynamodb:ListTagsOfResource",
              "dynamodb:UpdateContributorInsights",
              "dynamodb:CreateBackup",
              "dynamodb:UpdateContinuousBackups",
              "dynamodb:PartiQLSelect",
              "dynamodb:UpdateGlobalTableVersion",
              "dynamodb:CreateGlobalTable",
              "dynamodb:DescribeKinesisStreamingDestination",
              "dynamodb:ImportTable",
              "dynamodb:ConditionCheckItem",
              "dynamodb:Query",
              "dynamodb:DescribeStream",
              "dynamodb:DeleteTableReplica",
              "dynamodb:DescribeTimeToLive",
              "dynamodb:DescribeGlobalTableSettings",
              "dynamodb:DescribeGlobalTable",
              "dynamodb:RestoreTableFromBackup",
              "dynamodb:DeleteBackup",
              "dynamodb:PartiQLDelete"
            ],
            "Resource" : "arn:aws:dynamodb:us-east-1:160884609839:table/EC2TF"
          },
          {
            "Sid" : "VisualEditor2",
            "Effect" : "Allow",
            "Action" : [
              "logs:CreateLogStream",
              "logs:PutLogEvents"
            ],
            "Resource" : "arn:aws:logs:us-east-1:160884609839:log-group:/aws/lambda/dynamo:*"

            "Resource" : "arn:aws:lambda:us-east-1:160884609839:log-group:/aws/lambda/get_stop_instance:*"
          }
        ]
      }
    )
  }
}


