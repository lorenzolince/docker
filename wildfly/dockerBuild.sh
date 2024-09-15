#Author Lorenzo Lince
#Shell Script automates the wildfly app docker build
#!/bin/bash
docker build --progress=plain --no-cache --tag=wildfly-app .

