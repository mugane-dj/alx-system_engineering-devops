#!/usr/bin/python3
"""
Module that makes a get request to a REST API
"""
import json
import requests
import sys


if __name__ == "__main__":
    url = "https://jsonplaceholder.typicode.com"

    # Get all users
    users = requests.get(url=url + "/users").json()

    # Get user's todos
    output = {}
    for user in users:
        user_id = user.get("id")
        username = user.get("username")
        todos = requests.get(url=url +
                             "/users/{}/todos".format(user_id)).json()
        todo_list = []
        for todo in todos:
            task_dict = {}
            task_dict['username'] = username
            task_dict['task'] = todo.get("title")
            task_dict['completed'] = todo.get("completed")
            todo_list.append(task_dict)

        key = "{}".format(user_id)
        output[key] = todo_list

    filename = "todo_all_employees.json"
    with open(filename, 'w') as f:
        json.dump(output, f)
