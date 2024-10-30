#!/bin/bash

# Variables
ES_HOST=""
ES_PORT="9200"
ES_USER="elastic"
ES_PASS=""
REPOSITORY="backup"
SNAPSHOT_NAME="snapshot_$(date +%Y%m%d_%H%M%S)"

# Function to create a snapshot
echo "Creating snapshot: $SNAPSHOT_NAME..."
curl -u "$ES_USER:$ES_PASS" -X PUT "$ES_HOST:$ES_PORT/_snapshot/$REPOSITORY/$SNAPSHOT_NAME?wait_for_completion=true" -H 'Content-Type: application/json' -d'
{
    "indices": "*",
    "ignore_unavailable": true,
    "include_global_state": false
}'

echo "\nSnapshot $SNAPSHOT_NAME created."

