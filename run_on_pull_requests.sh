#!/bin/bash

docker-compose down --volumes && git pull && docker-compose up -d --build