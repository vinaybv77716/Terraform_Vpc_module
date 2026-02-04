resource "aws_wafv2_ip_set" "ipset" {
  name               = "ip-set"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = var.ip_addresses
}

resource "aws_wafv2_web_acl" "webacl" {
  name  = "web-acl"
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
  name     = "test-block-gitlab-header"
  priority = 1

  action {
    block {}
  }

  statement {
    byte_match_statement {
      search_string = "gitlab-test"

      field_to_match {
        single_header {
          name = "x-gitlab-test"
        }
      }

      positional_constraint = "EXACTLY"

      text_transformation {
        priority = 0
        type     = "NONE"
      }
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "testBlockGitlabHeader"
    sampled_requests_enabled   = true
  }
}


  rule {
    name     = "IP-Rule"
    priority = 0

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.ipset.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "ip-rule"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "Geo-Rule"
    priority = 2

    action {
      block {}
    }

    statement {
      geo_match_statement {
        country_codes = var.blocked_countries
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "geo-rule"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "web-acl"
    sampled_requests_enabled   = true
  }
}

resource "aws_wafv2_web_acl_association" "alb_assoc" {
  resource_arn = aws_lb.alb.arn
  web_acl_arn  = aws_wafv2_web_acl.webacl.arn
}
