#!/usr/bin/python3
"""
Module that makes a get request to a REST API
"""
import json
import requests
import sys


if __name__ == "__main__":
    employee_id = sys.argv[1]
    url = "https://jsonplaceholder.typicode.com"

    # Get employee's name
    user_response = requests.get(url=url + "/users/{}".format(employee_id))
    user_data = user_response.json()
    employee_username = user_data.get("username")

    # Get employee's todos
    todos = requests.get(url=url + "/users/{}/todos"
                         .format(employee_id)).json()
    filename = "{}.json".format(employee_id)
    with open(filename, 'w') as f:
        todo_list = []
        output = {}
        for todo in todos:
            task_dict = {}
            task_dict['task'] = todo.get("title")
            task_dict['completed'] = todo.get("completed")
            task_dict['username'] = employee_username
            todo_list.append(task_dict)

        key = "{}".format(employee_id)
        output[key] = todo_list
        json.dump(output, f)
