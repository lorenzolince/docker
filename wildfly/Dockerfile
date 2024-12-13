FROM jboss/wildfly

#Autor
MAINTAINER Lorenzo Lince<lorenzolince@gmail.com>

ENV JBOSS_HOME /opt/jboss/wildfly
USER root
RUN mkdir -p /opt/oracle
RUN mkdir -p /opt/mssql

RUN curl --output /opt/oracle/ojdbc8-21.3.0.0.jar  https://repo1.maven.org/maven2/com/oracle/database/jdbc/ojdbc8/21.3.0.0/ojdbc8-21.3.0.0.jar
RUN curl --output /opt/oracle/xdb6-12.1.0.1.jar http://maven.in2p3.fr/com/oracle/xdb6/12.1.0.1/xdb6-12.1.0.1.jar
RUN curl --output /opt/mssql/mssql-jdbc-8.4.1.jre8.jar https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/8.4.1.jre8/mssql-jdbc-8.4.1.jre8.jar


COPY scripst/* $JBOSS_HOME/bin/

RUN $JBOSS_HOME/bin/setup.sh

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "-c", "standalone-full.xml"]
