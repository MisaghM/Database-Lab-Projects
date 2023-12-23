import json

import jdatetime
import redis

JSON_FILE_PATH = "tweets.json"

r = redis.Redis(host="localhost", port=6379, db=0)


def jdatetime_from_timestamp(timestamp: int):
    return jdatetime.datetime.fromtimestamp(timestamp)


def get_keys(timestamp: int):
    jtime = jdatetime_from_timestamp(timestamp)
    day_key = f"Hashtags:{str(jtime.date())}"
    daytime_key = f"Hashtags:{str(jtime.date())}:{jtime.hour + 1:02}"
    return day_key, daytime_key


def get_hashtags(content: str):
    return [word for word in content.split() if word.startswith("#")]


def initialize():
    with open(JSON_FILE_PATH, "r", encoding="utf-8-sig") as f:
        data = json.load(f)
    for item in data:
        day_key, daytime_key = get_keys(item["release_timestamp"])
        hashtags = get_hashtags(item["text"])
        for hashtag in hashtags:
            r.zincrby(day_key, 1, hashtag)
            r.zincrby(daytime_key, 1, hashtag)


def get_top_hashtags(key: str, top: int):
    return r.zrevrange(key, 0, top - 1, withscores=True)


def get_top_hashtags_by_day(day: str, top: int):
    return get_top_hashtags(f"Hashtags:{day}", top)


def get_top_hashtags_by_daytime(day: str, hour: int, top: int):
    return get_top_hashtags(f"Hashtags:{day}:{hour + 1:02}", top)


def print_results(day: str):
    top_day_hashtags = get_top_hashtags_by_day(day, 10)
    print(f"Top hashtags of {day}:")
    for hashtag, count in top_day_hashtags:  # type: ignore
        print(f'{hashtag.decode("utf-8")} ({count})')

    print(f"Top hashtags of each hour:")
    for hour in range(24):
        print(f"Hour {hour}:")
        top_day_hour_hashtags = get_top_hashtags_by_daytime(day, hour, 3)
        for hashtag, count in top_day_hour_hashtags:  # type: ignore
            print(f'{hashtag.decode("utf-8")} ({count})')


def main():
    initialize()
    day = "1402-09-26"
    print_results(day)


if __name__ == "__main__":
    main()
