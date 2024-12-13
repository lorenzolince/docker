#!/bin/bash
echo "Adding WildFly management user..."
$JBOSS_HOME/bin/add-user.sh -u 'llince' -p '123456' -g 'PowerUser,BillingAdmin'
$JBOSS_HOME/bin/add-user.sh -a -u 'user-test' -p '123456.' -g 'guest'

ORACLE_COMMAND="module add --name=com.oracle.ojdbc8 --resources=/opt/oracle/ojdbc8-21.3.0.0.jar:/opt/oracle/xdb6-12.1.0.1.jar --dependencies=javax.api,javax.transaction.api"

MSSQL_COMMAND="module add --name=com.microsoft.sqlserver --resources=/opt/mssql/mssql-jdbc-8.4.1.jre8.jar --dependencies=javax.api,javax.transaction.api"

echo "Starting WildFly in admin-only mode..."
# Start server
cd $JBOSS_HOME/bin
./standalone.sh -c standalone-full.xml --admin-only &


# Wait for server to fully start
echo "Waiting for the WildFly server to start..."
started=1
while [ $started -ne 0 ]
do
  sleep 2
  ./jboss-cli.sh --connect --command=":read-attribute(name=server-state)" | grep -q running
  started=$?
  echo "Server state exit code=$started, waiting..."
done

echo "Adding Oracle module..."
# Add oracle module
./jboss-cli.sh --connect --command="$ORACLE_COMMAND"

# Add Sqlserver module
./jboss-cli.sh --connect --command="$MSSQL_COMMAND"

# Execute cli-commands file
# Ejecutar los comandos desde el archivo cli-commands
if [ -f "$JBOSS_HOME/bin/cli-commands" ]; then
  echo "Executing CLI commands..."
  ./jboss-cli.sh --connect --file="$JBOSS_HOME/bin/cli-commands"
  rm -rf $JBOSS_HOME/bin/cli-commands
fi


sleep 2

# Clear server history after shutdown
rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history

echo "Setting JVM timezone..."

# Set JVM timezone property, this solves a problem with de Oracle JDBC driver using Oracle XE 11g
echo "JAVA_OPTS=\"\$JAVA_OPTS -Duser.timezone=GMT\"" >> $JBOSS_HOME/bin/standalone.conf
