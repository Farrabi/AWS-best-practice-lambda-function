import requests
from json import loads
from string import Template
import os

ENDPOINT_URL = os.environ['API_ENDPOINT']
HEADERS = {
    'x-api-key': os.environ['API_KEY']
}


def format_reset_query(mail, role):
    return Template('mutation resetUser {resetUser(mail: "${mail}", role: "${role}") {usermail}}').substitute(mail=mail,
                                                                                                              role=role)


def make_query(query):
    print(query)
    return requests.request('POST', ENDPOINT_URL, json=query, headers=HEADERS)


def reset_users():
    print('Resetting users...')
    user_response = make_query({"query": "query GetUsers { users { usermail\r\n useradmin } }"})
    for key in loads(user_response.text)['data']['users']:
        role = "supervisor" if key['useradmin'] else "agent"
        reset = make_query({'query': format_reset_query(key['usermail'], role)})
    return True


def lambda_handler(e, c):
    reset_users()
    return True
