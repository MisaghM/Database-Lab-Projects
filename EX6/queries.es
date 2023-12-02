PUT twitter
{
    "settings": {
        "index": {
            "number_of_shards": 1,
            "number_of_replicas": 0
        },
        "analysis": {
            "filter": {
                "filter_persian_common": {
                    "type": "common_grams",
                    "common_words": "_persian_"
                },
                "filter_persian_common_search": {
                    "type": "common_grams",
                    "common_words": "_persian_",
                    "query_mode": true
                }
            },
            "analyzer": {
                "persian_common": {
                    "tokenizer": "whitespace",
                    "filter": [
                        "filter_persian_common"
                    ]
                },
                "persian_common_search": {
                    "tokenizer": "whitespace",
                    "filter": [
                        "filter_persian_common_search"
                    ]
                }
            },
            "normalizer": {
                "lowercase_normalizer": {
                    "type": "custom",
                    "filter": [
                        "lowercase"
                    ]
                }
            }
        }
    },
    "mappings": {
        "properties": {
            "content": {
                "type": "text",
                "analyzer": "persian_common",
                "search_analyzer": "persian_common_search"
            },
            "id": {
                "type": "integer"
            },
            "type": {
                "type": "keyword"
            },
            "likeCount": {
                "type": "integer"
            },
            "retwitCount": {
                "type": "integer"
            },
            "sendTime": {
                "type": "date"
            }
        }
    }
}

// python3 send_to_elastic.py

// Q1
GET twitter/_search
{
    "query": {
        "term": {
            "senderUsername": "jalaleskandari"
        }
    }
}

// Q2
GET twitter/_count
{
    "query": {
        "term": {
            "senderUsername": "bourse_iran_"
        }
    }
}

// Q3
GET twitter/_count
{
    "query": {
        "query_string": {
            "query": "content:فولاد AND content:فملی"
        }
    }
}

// Q4
GET twitter/_search
{
    "query": {
        "term": {
            "type": "retwit"
        }
    },
    "sort": [
        {
            "likeCount": {
                "order": "desc"
            }
        }
    ]
}

// Q5
GET twitter/_search
{
    "_source": [
        "senderUsername"
    ],
    "query": {
        "query_string": {
            "query": "content:وآیند OR content:وسالت"
        }
    }
}

// Q6
GET twitter/_search
{
    "query": {
        "range": {
            "sendTime": {
                "gte": "2021-12-13",
                "lte": "2021-12-14"
            }
        }
    },
    "size": 3
}

// Q7
GET twitter/_search
{
    "query": {
        "regexp": {
            "senderUsername": ".*[ms].*"
        }
    },
    "aggs": {
        "sum_likeCount": {
            "sum": {
                "field": "likeCount"
            }
        }
    },
    "size": 0
}

// Q8
GET twitter/_search
{
    "size": 0,
    "aggs": {
        "count_type": {
            "terms": {
                "field": "type"
            }
        }
    }
}

// Q9
GET twitter/_search
{
    "size": 0,
    "aggs": {
        "likeCount": {
            "stats": {
                "field": "likeCount"
            }
        }
    }
}
