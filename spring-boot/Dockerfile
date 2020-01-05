FROM openjdk:8-jdk-alpine
MAINTAINER Lorenzo Lince<lorenzolince@gmail.com>

RUN apk add --update netcat-openbsd && rm -rf /var/cache/apk/*
RUN mkdir apps
COPY entrypoint/* /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
