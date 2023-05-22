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
    employee_name = user_data.get("name")

    # Get employee's todos
    todos = requests.get(url=url + "/users/{}/todos"
                         .format(employee_id)).json()
    total_number_of_todos = len(todos)
    number_of_completed_todos = 0
    titles = []
    for todo in todos:
        if todo.get("completed") is True:
            number_of_completed_todos += 1
            titles.append(todo.get("title"))

    # Format and print output
    print("Employee {} is done with tasks({}/{}):"
          .format(employee_name, number_of_completed_todos,
                  total_number_of_todos))
    for title in titles:
        print("\t {}".format(title))
