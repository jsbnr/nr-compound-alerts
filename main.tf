module "CompoundAlert1" {
  source = "./modules/CompoundAlerter"
  policyName = "Compound Alerter (Fruit)"
  accountId = var.terraformNRAccountId
  targetPolicyId = newrelic_alert_policy.mock_policy.id
  threshold = 2
}


# Example slack notification channel
resource "newrelic_alert_channel" "slack" {
  name = "Compound alert Slack example"
  type = "slack"

  config {
    url     = var.slackChannelURL
    channel = "example-alerts-channel"
  }
}

resource "newrelic_alert_policy_channel" "slack" {
  policy_id  = module.CompoundAlert1.id
  channel_ids = [
    newrelic_alert_channel.slack.id
  ]
}