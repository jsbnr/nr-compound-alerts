# New Relic Compound (conditional) Alert
This example shows how you might use two policies to synthesize a compound alert. The idea being that you only alert if all the conditions in one policy are violating. Unfortunately due to the 2 hour limit on NRQL alerts this only works if the conditions all violate within the same 2 hour window. Its not ideal.

## Usage
Apply with terraform. The runtf.sh.example script can be used to easily provide the required inputs.  Configure the alerts as you like. The built in demo can be run by sending mock data with moock-issues.sh to send fake issues to the alerts. (in this case use the terms APPLES and PEARS :) )