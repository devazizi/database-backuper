if [ -z "$1" ]; then
  echo "Usage: $0 <backup_file> <s3_remote> <s3_bucket>"
  exit 1
fi

if [ -z "$2" ]; then
  echo "Usage: $0 <backup_file> <s3_remote> <s3_bucket>"
  exit 1
fi

if [ -z "$3" ]; then
  echo "Usage: $0 <backup_file> <s3_remote> <s3_bucket>"
  exit 1
fi


BACKUP_FILE="$1"
S3_REMOTE="$2"
S3_BUCKET="$3"
TAR_FILE_NAME="$BACKUP_FILE.tar.gz"

tar -czvf "$TAR_FILE_NAME" "$BACKUP_FILE"

rclone copy "$TAR_FILE_NAME" "$S3_REMOTE:$S3_BUCKET"

rm "$TAR_FILE_NAME"
