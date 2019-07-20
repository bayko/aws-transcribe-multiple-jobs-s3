# AWS Transcribe - Multiple Job Queue

## This script will create multiple AWS Transcribe jobs out of a S3 bucket containing video/audio files

#### Requirements
- AWS account credentials must be configured on local terminal  (set using: aws configure)
- jq binary must be installed (installation instructions found here: https://stedolan.github.io/jq/download/)

### Adjust parameters to your environment
```
# S3 Bucket Name
BUCKET_NAME="example-bucket"

# Folder in bucket containing files
PARENT_FOLDER="video-files"

# Optional sub-folder - leave value as "" if none
SUB_FOLDER=""

# Format for the media files being transcribed
MEDIA_FORMAT="mp4"

# Language for Transcription
LANGUAGE_CODE="en-US"

# Optional name of custom vocabulary - leave value as "" if none
CUSTOM_VOCABULARY=""

# Desired AWS region to create transribe jobs in
AWS_REGION="us-east-1"
```
### After custom parameters are set simply execute the script at the command line
```
~>:  ./queue-transcribe.sh
```

