FROM wnameless/oracle-xe-11g-r2

MAINTAINER Lorenzo Lince <lorenzolince@gmail.com>

RUN mkdir /scripts

COPY init/* /scripts/

RUN mv /scripts/init.sql /docker-entrypoint-initdb.d/
