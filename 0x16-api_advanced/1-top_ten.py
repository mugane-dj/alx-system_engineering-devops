#!/usr/bin/python3
"""
Module contains a function that queries the Reddit API
and returns the list of top 10 hot posts for a given subreddit.
"""
import requests


def top_ten(subreddit):
    """
    Fetches the top ten hot posts in a subreddit.
    subreddit: subreddit to fetch the top ten hot posts in a subreddit from.
    """
    url = "https://www.reddit.com/r/{}/hot.json?limit=10".format(subreddit)
    headers = {
        "User-Agent": "Chrome/91.0.4472.124"
    }
    res = requests.get(url, headers=headers, timeout=10)
    json_res = res.json()
    data = json_res.get("data")

    if res.status_code == 200:
        hot_posts = data.get("children")
        for post in hot_posts:
            print(post.get("data").get("title"))
    else:
        print(None)
