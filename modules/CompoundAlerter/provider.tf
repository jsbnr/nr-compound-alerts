terraform {
  required_version = "~> 1.0.1"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 2.25.0"
    }
  }
}