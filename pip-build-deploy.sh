#!/usr/bin/env bash

BASE_DIR=$1
ALL_SERVICES=(pip-subscription-management pip-data-management pip-publication-services pip-account-management pip-channel-management pip-frontend)

docker compose down

for SERVICE in ${ALL_SERVICES[@]}; do
    docker build $BASE_DIR/$SERVICE --build-arg APP=$SERVICE.jar -t $SERVICE
done

docker compose up -d