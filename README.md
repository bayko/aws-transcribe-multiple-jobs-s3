# AWS Transcribe - Multiple Job Queue

## This script will create multiple AWS Transcribe jobs out of a S3 bucket containing video/audio files

### Simply adjust parameters to your requirements
```
# S3 Bucket Name
BUCKET_NAME="example-bucket"

# Folder in bucket containing files
PARENT_FOLDER="video-files"

# Optional sub-folder - leave value as "" if none
SUB_FOLDER="raw-files"

# Format for the media files being transcribed
MEDIA_FORMAT="mp4"

# Language for Transcription
LANGUAGE_CODE="en-US"

# Optional name of custom vocabulary to use - leave value as "" if none
CUSTOM_VOCABULARY="my-aws-vocabulary"

# Desired AWS region to create transribe jobs in
AWS_REGION="us-east-1"
```
