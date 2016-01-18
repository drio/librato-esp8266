#!/bin/bash

# { plain: "temperature:22", hashed: "XXXXXX" }

secret="secret"
message="message"

# -d '{"temp": "22"}' \
# echo -n "value" | openssl dgst -sha1 -hmac "key"

#r=$RANDOM
temp=$1 || 22
hashed=$(echo -n "$temp" | \
    openssl dgst -md5 -hmac $secret)

echo '{"'"plain"'": "'"$temp"'", "'"hash"'": "'"$hashed"'"}' > payload.txt

curl \
    --trace-ascii /dev/stdout \
    -i \
    -H "Content-Type: application/json" \
    -X POST \
    --data @./payload.txt \
    192.241.240.105:5000/proxy
#    192.168.1.212:80/proxy
