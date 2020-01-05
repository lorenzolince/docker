#Author Lorenzo Lince
#Shell Script automates the spring boot app docker build
#!/bin/bash
docker build --tag=spring-boot-admin .
docker build --tag=spring-boot-app .
