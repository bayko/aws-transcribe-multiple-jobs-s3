# AWS Transcribe - Multiple Job Queue

## This script will create multiple AWS Transcribe jobs out of a S3 bucket containing video/audio files

#### Requirements
- AWS account credentials must be configured on your local terminal  (instructions found here: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
- jq binary must be installed (installation instructions found here: https://stedolan.github.io/jq/download/)
- Script automatically ignores any files in the bucket not matching provided media type
- All files in target folder that match the provided media type will be submitted to AWS Transcribe

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

#### After completion of the script you can check your transcription job progress within the AWS Transcribe Console
- https://console.aws.amazon.com/transcribe/
