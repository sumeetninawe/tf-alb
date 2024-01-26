resource "aws_wafv2_web_acl" "my_waf" {
  name  = "my-waf-acl"
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "my-waf-metric"
    sampled_requests_enabled   = false
  }
}

resource "aws_wafv2_web_acl_association" "waf-alb" {
  resource_arn = aws_lb.my_alb.arn
  web_acl_arn  = aws_wafv2_web_acl.my_waf.arn
}