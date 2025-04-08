resource "aws_wafv2_web_acl" "example_web_acl" {
  name  = local.waf
  scope = "CLOUDFRONT"
  default_action {
    block {
    }
  }
  rule {
    name     = "AllowAlbRobotsTxt"
    priority = 1
    action {
      allow {

      }
    }
    statement {
      byte_match_statement {
        field_to_match {
          method {

          }
        }
        positional_constraint = "EXACTLY"
        search_string         = "GET"
        text_transformation {
          priority = 10
          type     = "None"
        }
      }
      and_statement {
        statement {
          byte_match_statement {
            field_to_match {
              uri_path {

              }
            }
            positional_constraint = "EXACTLY"
            search_string         = "/robots.txt"
            text_transformation {
              priority = 10
              type     = "None"
            }
          }
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AllowAlbRobotsTxt"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "AWSManagedRulesAmazonIpReputationList"
    priority = 2
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
        rule_action_override {
          name = "AWSManagedIPDDoSList"
          action_to_use {
            block {

            }
          }
        }
        scope_down_statement {
          not_statement {
            statement {
              label_match_statement {
                scope = "NAMESPACE"
                key   = "trusted-ip"
              }
            }
          }
        }
      }
    }
    override_action {
      none {

      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesAmazonIpReputationList"
      sampled_requests_enabled   = true
    }

  }
  rule {
    name     = "AWSManagedRulesAnonymousIpList"
    priority = 2
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAnonymousIpList"
        vendor_name = "AWS"
        scope_down_statement {
          not_statement {
            statement {
              label_match_statement {
                scope = "NAMESPACE"
                key   = "trusted-ip"
              }
            }
          }
        }
      }
    }
    override_action {
      none {
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesAnonymousIpList"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "DropOversizedHeaders"
    priority = 2
    statement {
      size_constraint_statement {
        field_to_match {
          headers {
            match_pattern {
              all {

              }
            }
            match_scope       = "ALL"
            oversize_handling = "MATCH"
          }
        }
        comparison_operator = "GT"
        size                = 8192
        text_transformation {
          priority = 10
          type     = "NONE"
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "DropOversizedHeaders"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "DropOversizedCookies"
    priority = 3
    action {
      block {

      }
    }
    statement {
      size_constraint_statement {
        field_to_match {
          headers {
            match_pattern {
              all {
              }
            }
            match_scope       = "ALL"
            oversize_handling = "MATCH"
          }
        }
        comparison_operator = "GT"
        size                = 8192
        text_transformation {
          priority = 10
          type     = "NONE"
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "DropOversizedCookies"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "DropOversizedRequestBody-64KiB"
    priority = 4
    action {
      count {
      }
    }
    statement {
      and_statement {
        statement {
          size_constraint_statement {
            field_to_match {
              body {
                oversize_handling = "MATCH"
              }
            }
            comparison_operator = "GT"
            size                = 65536
            text_transformation {
              priority = 10
              type     = "NONE"
            }
          }
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "DropOversizedRequestBody-64KiB"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "DropOversizedRequestBody-48KiB"
    priority = 4
    action {
      count {
      }
    }
    statement {
      and_statement {
        statement {
          size_constraint_statement {
            field_to_match {
              body {
                oversize_handling = "MATCH"
              }
            }
            comparison_operator = "GT"
            size                = 49152
            text_transformation {
              priority = 10
              type     = "NONE"
            }
          }
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "DropOversizedRequestBody-48KiB"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "DropOversizedRequestBody-16KiB"
    priority = 4
    action {
      count {
      }
    }
    statement {
      and_statement {
        statement {
          size_constraint_statement {
            field_to_match {
              body {
                oversize_handling = "MATCH"
              }
            }
            comparison_operator = "GT"
            size                = 16384
            text_transformation {
              priority = 10
              type     = "NONE"
            }
          }
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "DropOversizedRequestBody-48KiB"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 1
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
        rule_action_override {
          name = "SizeRestrictions_BODY"
          action_to_use {
            count {
            }
          }
        }
        rule_action_override {
          name = "CrossSiteScripting_Body"
          action_to_use {
            count {
            }
          }
        }
      }
    }
    override_action {
      none {
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesAdminProtectionRuleSet"
    priority = 1
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAdminProtectionRuleSet"
        vendor_name = "AWS"
      }
    }
    override_action {
      none {
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = ""
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "AWSManagedRulesKnownBadInputsRuleSet"
    priority = 1
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }
    override_action {
      none {
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesKnownBadInputsRuleSet"
      sampled_requests_enabled   = true
    }

  }
  rule {
    name     = "AWSManagedRulesSQLiRuleSet"
    priority = 1
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
        rule_action_override {
          name = "SQLi_BODY"
          action_to_use {
            count {
            }
          }
        }
        rule_action_override {
          name = "SQLiExtendedPatterns_BODY"
          action_to_use {
            count {
            }
          }
        }
      }
    }
    override_action {
      none {
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesSQLiRuleSet"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "AWSManagedRulesPHPRuleSet"
    priority = 1
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesPHPRuleSet"
        vendor_name = "AWS"
      }
    }
    override_action {
      none {}
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesPHPRuleSet"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "DropLessThanGreaterThanInUriPath"
    priority = 1
    action {
      block {}
    }
    statement {
      or_statement {
        statement {
          regex_match_statement {
            field_to_match {
              uri_path {
              }
            }
            regex_string = "[<>]"
            text_transformation {
              priority = 10
              type     = "NONE"
            }
          }
        }
        statement {
          regex_match_statement {
            field_to_match {
              uri_path {
              }
            }
            regex_string = "[<>]"
            text_transformation {
              priority = 10
              type     = "URL_DECODE"
            }
          }
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "DropLessThanGreaterThanInUriPath"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "DropEncodedPercentageSignInUriPath"
    priority = 1
    action {
      block {
      }
    }
    statement {
      regex_match_statement {
        field_to_match {
          uri_path {}
        }
        regex_string = "%25"
        text_transformation {
          priority = 10
          type     = "NONE"
        }
      }

    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "DropEncodedPercentageSignInUriPath"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesLinuxRuleSet"
    priority = 1
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesLinuxRuleSet"
        vendor_name = "AWS"
      }
    }
    override_action {
      none {
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesLinuxRuleSet"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "AWSManagedRulesUnixRuleSet"
    priority = 1
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesUnixRuleSet"
        vendor_name = "AWS"
      }
    }
    override_action {
      none {
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesUnixRuleSet"
      sampled_requests_enabled   = true
    }
  }
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = local.waf
    sampled_requests_enabled   = true
  }
}
