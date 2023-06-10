#!/bin/bash

docker compose -f docker-compose-DEV.yml build --no-cache
docker compose -f docker-compose-DEV.yml up -d
docker compose -f docker-compose-DEV.yml logs -f
