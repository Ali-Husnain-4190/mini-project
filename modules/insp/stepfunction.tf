resource "aws_sfn_state_machine" "sfn_state_machine" {
  name       = "my-state-machine"
  role_arn   = aws_iam_role.step_function_role.arn
  type       = "STANDARD"
  definition = <<EOF
  {
    "StartAt": "GetID",
    "States": {
      "GetID": {
        "Type": "Task",
        "Resource":"${aws_lambda_function.get_value.arn}",
        "Next": "dynamoDB"
      },
      "dynamoDB":{
        "Type": "Task",
        "Resource":"${aws_lambda_function.dynamo.arn}",
        "Next":"email_send"
      },
       "email_send":{
        "Type": "Task",
        "Resource":"${aws_lambda_function.get_stop_instance.arn}",
        "Next":"IsTrue"
      },
    
      "IsTrue": {
          "Type": "Choice",
        "Choices": [
          {
            "Variable": "$.bool",
            "BooleanEquals": true,
            "Next": "Yes"
          },
          {
            "Variable": "$.bool",
            "BooleanEquals": false,
            "Next": "No"
          }
        ]
      },
       "Yes": {
        "Type": "Pass",
        "End": true
      },
       "No": {
        "Type": "Pass",
        "End": false
      }    
    }
  }
EOF
}
