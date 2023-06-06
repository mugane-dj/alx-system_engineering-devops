#!/usr/bin/python3
"""
Module contains a function that queries the Reddit API
and returns the number of total subscribers for a given subreddit.
"""
import requests


def number_of_subscribers(subreddit):
    """
    Fetches the number of total subscribers.
    subreddit: subreddit to fetch the number fo subscribers from.
    Return: number of subscribers or 0 if subreddit is invalid.
    """
    url = "https://www.reddit.com/r/{}/about.json".format(subreddit)
    headers = {
        "User-Agent": "Chrome/91.0.4472.124"
    }
    res = requests.get(url, headers=headers, timeout=10)
    json_res = res.json()
    data = json_res.get("data")

    if res.status_code == 200:
        return data.get("subscribers")
    else:
        return 0
