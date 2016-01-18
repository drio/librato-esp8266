#!flask/bin/python
from flask import Flask
from flask import request
from flask import abort
from flask import jsonify
import hashlib
import hmac
import base64
import librato

app = Flask(__name__)

user   = 'USER'
token  = 'TOKEN'
secret = 'secret'
api    = librato.connect(user, token)

@app.route('/')
def index():
    return "Hello, World!"

@app.route('/proxy', methods=['POST'])
def proxy_temp():
    if not request.json or \
       not 'plain' in request.json  or \
       not 'hash' in request.json:
        abort(400, 'invalid request')

    plain_temp = str(request.json["plain"])
    hash_temp  = str(request.json["hash"])
    local_hash = hmac.new(secret, plain_temp).hexdigest()
    if local_hash == hash_temp:
        api.submit("drd.iot.temp", plain_temp)
    else:
        abort(400, 'illegitimate requets')

    return 'ok :)', 200

if __name__ == '__main__':
    app.run(host='0.0.0.0',debug=True)
