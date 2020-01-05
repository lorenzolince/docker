#!/usr/bin/env sh
if [ "$WAIT_APP" = "true" ] ; then

ARGUMENT=$ARG_URL
HOST="$(echo $ARGUMENT | cut -d ':' -f1)"
PORT="$(echo $ARGUMENT | cut -d ':' -f2)"
MAX_RETRY=90

echo "Testing connection to host $HOST and port $PORT."

count=0
while [ $count -lt $MAX_RETRY ]
do
    count=$((count+1))
    nc -z $HOST $PORT
    result=$?
    if [ $result -eq 0 ]; then
        echo "Connection is available after $count second(s)."
      break
    fi
    echo "$count Retrying..."
    sleep 1
done
else
echo "no wait"
fi

find apps -type f -name "*.jar" -exec echo "java -jar "/{} "&" \; | sort -k 5 -n > /usr/local/bin/run.sh
sed -i '$ s/.$//' /usr/local/bin/run.sh
/usr/local/bin/run.sh 



