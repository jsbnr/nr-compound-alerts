variable terraformAPIKey { description="A New Relic user licence key managing resources via terraform provider"}
variable terraformNRAccountId  { description = "New Relic Account ID for terraform resources"} 

#If using slack channel...
variable "slackChannelURL" { description="Slack webhook URL"}