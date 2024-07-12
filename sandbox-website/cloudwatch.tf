
resource "aws_cloudwatch_metric_alarm" "cognito_login_outside_canada_warn" {
  alarm_name          = "AWSCognitoLoginOutsideCanadaAlarm"
  namespace           = "AWS/WAFV2"
  metric_name         = "CountedRequests"
  statistic           = "SampleCount"
  period              = "300"
  comparison_operator = "GreaterThanThreshold"
  threshold           = "0"
  evaluation_periods  = "1"
  treat_missing_data  = "notBreaching"
  provider            = aws.us-east-1

  dimensions = {
    Rule   = local.cognito_login_outside_canada_rule_name
    WebACL = aws_wafv2_web_acl.forms_acl.name
  }

  alarm_description = "Forms: A sign-in by a forms owner has been detected from outside of Canada."
}
