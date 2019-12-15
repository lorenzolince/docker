#!/bin/bash

ORACLE_COMMAND="module add --name=com.oracle.ojdbc7 --resources=/opt/oracle/ojdbc7-12.1.0.1.jar:/opt/oracle/xdb6-12.1.0.1.jar --dependencies=javax.api,javax.transaction.api"

# Start server
cd $JBOSS_HOME/bin
./standalone.sh -c standalone-full.xml --admin-only &


# Wait for server to fully start
echo "Waiting for the jboss server to start"
started=1
while [ $started -ne 0 ]
do
  2>/dev/null 1>/dev/null ./jboss-cli.sh --connect --command=":read-attribute(name=server-state)";
  started=$?
  echo "exit-code=$started, waiting...";
done

# Add oracle module
./jboss-cli.sh --connect --command="$ORACLE_COMMAND"

# Execute cli-commands file
./jboss-cli.sh --connect --file="$JBOSS_HOME/bin/cli-commands"

$JBOSS_HOME/bin/add-user.sh -a -u 'user-test' -p '123456.' -g 'guest'

rm -rf $JBOSS_HOME/bin/cli-commands

sleep 2

# Clear server history after shutdown
rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history

# Set JVM timezone property, this solves a problem with de Oracle JDBC driver using Oracle XE 11g
echo "JAVA_OPTS=\"\$JAVA_OPTS -Duser.timezone=GMT\"" >> $JBOSS_HOME/bin/standalone.conf
