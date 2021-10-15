#!/bin/sh

echo "Selenium Hub - $HUB_HOST"
echo "Browser is - $BROWSER"

echo "Validate $HUB_HOST status.."
STATUS=$(curl -s http://selenium-hub:4444/wd/hub/status | jq -r .value.ready)

#Loop until the status is true
while [ ! ${STATUS} ]
do
 sleep 1
done

echo "Status of Selenium Hub is - $STATUS"

# start the maven command
mvn test -DHUB_HOST=$HUB_HOST -DBROWSER=$BROWSER