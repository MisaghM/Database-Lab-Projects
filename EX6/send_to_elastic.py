from elasticsearch import Elasticsearch, helpers
import json

path = "./sample.json"
f = open (path, "r",encoding='utf-8-sig')
data = json.loads(f.read())

data = [{'_index':'twitter','_source':item} for item in data]

elastic_object = Elasticsearch(hosts='http://127.0.0.1:9200')

results = helpers.parallel_bulk(client=elastic_object, actions=data)
result = [item for item in results]
print(result)