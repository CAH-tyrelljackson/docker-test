#!/bin/bash -x
for machine in ${CONTAINER}
do
MARATHON_HOST="run.cahcommtech.net:80"
MACHINE="dockervalidation"
MACHINE_DESC="deploy.json"

TIMEOUT=600

cd ${WORKSPACE}/$machine

if [ -f "${MACHINE_DESC}" ]; then
  
  sed -i -e "s/latest/" ${MACHINE_DESC}  

  curl -X PUT -H "Content-Type: application/json" "http://${MARATHON_HOST}/v2/apps/${MACHINE}" -d@"${MACHINE_DESC}"
else
  exit -1
fi

done

exit $?
