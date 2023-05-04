resource "aws_cloudwatch_event_rule" "step_function_call" {
  name        = "Trigger-step-function"
  description = "Triger step function when Ec2 isntance stop"
  event_pattern = jsonencode({
    "source" : ["aws.ec2"],
    "detail-type" : ["EC2 Instance State-change Notification"],
    "detail" : {
      "state" : ["stopped"],
      "instance-id" : ["i-07df072de03c2e49a"]
    }
  })
}

resource "aws_cloudwatch_event_target" "step_function" {
  rule      = aws_cloudwatch_event_rule.step_function_call.name
  target_id = "TriggerStepFunction"
  arn       = aws_sfn_state_machine.sfn_state_machine.arn
  role_arn  = aws_iam_role.event_bridge_role.arn
}
