#!/bin/bash
# Run me as sudo to install all necessary dependencies
# and make sure to run this script inside the root directory of this repo

#################################################
# Build images
#################################################
docker build -f ./dockerfiles/jenkins.Dockerfile -t jenkins_python:latest .
docker build -f ./dockerfiles/bapi.Dockerfile -t bapi:latest .

# TODO: create jenkins agent
# docker build -f ./dockerfiles/agent.Dockerfile -t jenkins_agent:latest .

#################################################
# Deploy the docker compose stack
#################################################
docker compose -f ./docker-compose.yml up -d



# Folder size: 367.2 MiB

# docker system prune -a
# Total reclaimed space: 952MB

# CONTAINER ID   NAME      CPU %     MEM USAGE / LIMIT     MEM %     NET I/O          BLOCK I/O     PIDS
# ca2998f12931   jenkins   0.17%     618.7MiB / 31.29GiB   1.93%     1.89kB / 0B      0B / 3.47MB   52
# eb5890dd1627   bapi      0.00%     39.62MiB / 31.29GiB   0.12%     4.33MB / 109kB   0B / 2.1MB    18
# 841f38a7103e   gitea     0.02%     104.1MiB / 31.29GiB   0.32%     1.25kB / 0B      0B / 90.8MB   13