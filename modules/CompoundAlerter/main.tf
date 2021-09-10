# Inputs

variable policyName  { description = "Name for this policy"} 
variable accountId  { description = "The Account ID"} 
variable targetPolicyId  { description = "The ID of the policy with compound alerts"} 
variable threshold  { description = "The number of conditions open to cause an alert"} 

# Outputs
output "id" {
  value = newrelic_alert_policy.compound_alert_policy.id
}


resource "newrelic_alert_policy" "compound_alert_policy" {
  name = var.policyName
  incident_preference = "PER_POLICY" 
}

resource "newrelic_nrql_alert_condition" "condition" {
  account_id                   = var.accountId
  policy_id                    = newrelic_alert_policy.compound_alert_policy.id
  type                         = "static"
  name                         = "Compound alert trigger"
  enabled                      = true
  violation_time_limit_seconds = 7200
  value_function               = "single_value"

  fill_option          = "static"
  fill_value           = 0

  aggregation_window             = 30

  nrql {
    query             = "select count(*) as open from (SELECT latest(event) as status from NrAiIncident where policyId=${var.targetPolicyId}  facet conditionId) where status='open'"
    evaluation_offset = 2
  }

  critical {
    operator              = "above"
    threshold             = var.threshold - 1
    threshold_duration    = 60
    threshold_occurrences = "at_least_once"
  }

}