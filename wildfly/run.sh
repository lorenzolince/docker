#!/bin/bash

set -e

# Variables
set -a
[ -f .env ] && . .env
set +a

docker-compose up -d
