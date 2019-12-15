#FROM  imagen base
FROM jboss/wildfly

#Autor
MAINTAINER Lorenzo Lince<lorenzolince@gmail.com>
USER root
RUN mkdir -p /opt/oracle

COPY scripst/* $JBOSS_HOME/bin/

RUN curl --output /opt/oracle/ojdbc7-12.1.0.1.jar  http://maven.in2p3.fr/com/oracle/ojdbc7/12.1.0.1/ojdbc7-12.1.0.1.jar
RUN curl --output /opt/oracle/xdb6-12.1.0.1.jar http://maven.in2p3.fr/com/oracle/xdb6/12.1.0.1/xdb6-12.1.0.1.jar

RUN $JBOSS_HOME/bin/setup.sh

## ----------------------------------------------
## Add entrypoint script
## ----------------------------------------------
COPY entrypoint/* /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
