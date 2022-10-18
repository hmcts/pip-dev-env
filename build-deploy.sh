#!/usr/bin/env bash

BASE_DIR=$1

if [[ $# -lt 2 ]];
then
echo "Standard mode engaged - all services will be refreshed."
ALL_SERVICES=(pip-subscription-management pip-data-management pip-publication-services pip-account-management pip-channel-management pip-frontend)
elif [[ $# -eq 2 ]];
then
echo "Parametrised mode engaged - only $2 will be refreshed."
ALL_SERVICES=($2)
else
echo "Sorry - you've provided too many arguments (max 2)"
exit
fi

docker compose down

for SERVICE in ${ALL_SERVICES[@]}; do
    if [ $SERVICE != "pip-frontend" ]
    then
        (cd $BASE_DIR/$SERVICE  && ./gradlew assemble)
    fi
    docker build $BASE_DIR/$SERVICE --build-arg APP=$SERVICE.jar -t $SERVICE
done
docker compose up -d
