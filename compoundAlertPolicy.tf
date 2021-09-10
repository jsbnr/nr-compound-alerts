
#An example alert policy with multiple conditions. We want a notification when all of the conditions fire.

resource "newrelic_alert_policy" "mock_policy" {
  name = "Example Compound Alert Policy"
  incident_preference = "PER_CONDITION" 
}

resource "newrelic_nrql_alert_condition" "nrql_condition_1" {
  account_id                   = var.terraformNRAccountId
  policy_id                    = newrelic_alert_policy.mock_policy.id
  type                         = "static"
  name                         = "NRQL Condition 1 - APPLES"
  enabled                      = true
  violation_time_limit_seconds = 3600
  value_function               = "single_value"

  fill_option          = "static"
  fill_value           = 0

  aggregation_window             = 30
  expiration_duration            = 120
  open_violation_on_expiration   = false
  close_violations_on_expiration = true

  nrql {
    query             = "SELECT sum(mock.error) from Metric where app.name='mockalert' and mock.issues like '%APPLES%'"
    evaluation_offset = 2
  }

  critical {
    operator              = "above"
    threshold             = 0
    threshold_duration    = 60
    threshold_occurrences = "at_least_once"
  }

}


resource "newrelic_nrql_alert_condition" "nrql_condition_2" {
  account_id                   = var.terraformNRAccountId
  policy_id                    = newrelic_alert_policy.mock_policy.id
  type                         = "static"
  name                         = "NRQL Condition 2 - PEARS"
  enabled                      = true
  violation_time_limit_seconds = 3600
  value_function               = "single_value"

  fill_option          = "static"
  fill_value           = 0

  aggregation_window             = 30
  expiration_duration            = 120
  open_violation_on_expiration   = false
  close_violations_on_expiration = true

  nrql {
    query             = "SELECT sum(mock.error) from Metric where app.name='mockalert' and mock.issues like '%PEARS%'"
    evaluation_offset = 2
  }

  critical {
    operator              = "above"
    threshold             = 0
    threshold_duration    = 60
    threshold_occurrences = "at_least_once"
  }

}