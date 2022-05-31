import json

def   read_post_data_login():
        file = open('data/json_apis/json_apis_post_data_login.json', 'r')
        json_file = file.read()
        json_content = json.loads(json_file)
        return json_content


def read_post_data_device():
        file = open('data/json_apis/json_apis_post_data_device.json', 'r')
        json_file = file.read()
        json_content = json.loads(json_file)
        return json_content