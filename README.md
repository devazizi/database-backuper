## For make repository in elasticsearch
```bash
curl -u "your_username:your_password" -X PUT "http://localhost:9200/_snapshot/my_backup" -H 'Content-Type: application/json' -d'
{
  "type": "fs",
  "settings": {
    "location": "/usr/share/elasticsearch/backup",
    "compress": true
  }
}'
```
## Add this to elasticsearch.yml file 
```path.repo=/usr/share/elasticsearch/backup```