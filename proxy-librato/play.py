#!flask/bin/python

import hashlib
import hmac
import base64

message   = "message"
secret    = "secret"
signature = hmac.new(secret, message).hexdigest()
print type(message)
print message, secret, signature
