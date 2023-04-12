#!/bin/bash
docker-compose down --rmi all --remove-orphans
status=$?
if [ $status -eq 0 ]; then
    echo "*** All Capif services are cleaned ***"
else
    echo "*** Some Capif services failed on clean ***"
fi

(
cd ./nginx/certs/
sudo rm ca.crt sign_req_body.json server.*
cd ../..
sudo find . -type f -name '*.log' | xargs rm
sudo find . -type f -name '*.pem' | xargs rm
sudo find . -type f -name '*.key' | xargs rm
cd ..
sudo rm -R results
)

exit $status
