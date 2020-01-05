#FROM  imagen base
FROM jboss/base-jdk:8

#Autor
MAINTAINER Lorenzo Lince<lorenzolince@gmail.com>
ENV WILDFLY_VERSION 10.1.0.Final
ENV JBOSS_HOME /opt/jboss/wildfly
USER root
RUN mkdir -p /opt/oracle



RUN curl --output /opt/oracle/ojdbc7-12.1.0.1.jar  http://maven.in2p3.fr/com/oracle/ojdbc7/12.1.0.1/ojdbc7-12.1.0.1.jar
RUN curl --output /opt/oracle/xdb6-12.1.0.1.jar http://maven.in2p3.fr/com/oracle/xdb6/12.1.0.1/xdb6-12.1.0.1.jar

RUN cd $HOME \
    && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
    && mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
    && rm wildfly-$WILDFLY_VERSION.tar.gz \
    && chown -R jboss:0 ${JBOSS_HOME} \
    && chmod -R g+rw ${JBOSS_HOME}

COPY scripst/* $JBOSS_HOME/bin/

RUN $JBOSS_HOME/bin/setup.sh

## ----------------------------------------------
## Add entrypoint script
## ----------------------------------------------
COPY entrypoint/* /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
