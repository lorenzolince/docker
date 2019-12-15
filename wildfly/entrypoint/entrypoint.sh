#!/usr/bin/env bash


# wait indefinitely for the database to start before connecting
wait-for-it.sh $DB_HOST:$wait_port -t 0

# Start Wildfly Server
/bin/bash /opt/jboss/wildfly/bin/standalone.sh -b $(hostname) -c standalone-full.xml
