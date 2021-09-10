terraform {
  required_version = "~> 1.0.1"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 2.25.0"
    }
  }
}


provider "newrelic" {
  account_id = var.terraformNRAccountId            # Your New Relic account ID
  api_key = var.terraformAPIKey                    # Usually prefixed with 'NRAK'
  region = "US"                                    # Valid regions are US and EU
}