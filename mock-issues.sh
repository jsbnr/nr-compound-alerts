#!/bin/bash

APIKEY="$1"
ISSUES="$2"

# SELECT count(*) from Metric where app.name='mockalert' and mock.issues like '%ISSUE%'


if [ "$ISSUES" != "" ] && [ "$APIKEY" != "" ]; then
   
    echo "Press [CTRL+C] to stop..\n\n"

    while true
    do
        NOW=`date +%s`
        NOWD=`date`
        echo  -n "${NOWD}: Sending issue: '${ISSUES}' => "

        curl -s -o /dev/null -w "%{http_code}" -k -H "Content-Type: application/json" \
            -H "Api-Key: ${APIKEY}" \
            -X POST https://metric-api.newrelic.com/metric/v1 \
            --data "[{    \"common\" : {  \"attributes\": {   \"app.name\": \"mockalert\"   }    },   \"metrics\":[{ \"name\":\"mock.error\", \"type\":\"gauge\", \"value\":1, \"timestamp\":${NOW}, \"attributes\":{\"mock.issues\":\"${ISSUES}\"} }]     }]"

        echo ""
        sleep 30
    done
else
    echo "Must supply API key and issue string. e.g: ./mock-issues.sh apikey-here SEV1" 
fi 



