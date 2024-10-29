#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <container_name> <db username> <db password> <db name>"
  exit 1
fi

if [ -z "$2" ]; then
  echo "Usage: $0 <db username>"
  exit 1
fi

if [ -z "$2" ]; then
  echo "Usage: $0 <db password>"
  exit 1
fi

if [ -z "$3" ]; then
  echo "Usage: $0 <db password>"
  exit 1
fi


if [ -z "$4" ]; then
  echo "Usage: $0 <db name>"
  exit 1
fi

# variable for backup Database and backup configurations
DB_CONTAINER="$1"
DB_USER="$2"
DB_PASSWORD="$3"
DB_NAME="$4"
BACKUP_DIR="/var/backups/$DB_CONTAINER/$DB_NAME"
DATE=$(date +"%Y-%m-%d")
NETWORK=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.NetworkID}}{{end}}' "$DB_CONTAINER")

mkdir -p "$BACKUP_DIR"

# Run the backup command using Docker
# change docker postgres image tag by your requirements

docker run --rm \
  --network "$NETWORK" \
  --link "$DB_CONTAINER":postgres \
  -e PGPASSWORD="$DB_PASSWORD" \
  -v "$BACKUP_DIR:/var/db-backup" \
  postgres:16-alpine \
  sh -c "pg_dump -h postgres -U $DB_USER -d $DB_NAME > /var/db-backup/backup-$DB_NAME-$DATE.sql"

# remove backup from 7 days ago
if [ $? -eq 0 ]; then
     find "$BACKUP_DIR"  -mtime +7 -exec rm -rf {} \;
     echo "Local backup file since 7 day deleted successfully."
else
    echo "Error occurred during upload. Local backup file was not deleted."
fi