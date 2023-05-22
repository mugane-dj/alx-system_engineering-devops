#!/usr/bin/python3
"""Module that makes a get request to a REST API"""
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
    filename = "{}.csv".format(employee_id)
    with open(filename, 'w') as f:
        for todo in todos:
            user_id = todo.get("userId")
            task_status = todo.get("completed")
            task_title = todo.get("title")
            output = '"{}","{}","{}","{}"\n'.format(user_id, employee_username,
                                                    task_status, task_title)
            f.write(output)
