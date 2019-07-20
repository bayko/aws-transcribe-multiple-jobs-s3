# AWS Transcribe - Multiple Job Queue

## This script will create multiple AWS Transcribe jobs out of video or audio files saved in a S3 Bucket

#### Note
- AWS account credentials must be configured on your local terminal  (instructions found here: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
- jq binary must be installed on your machine (installation instructions found here: https://stedolan.github.io/jq/download/)
- Script automatically ignores any files in the bucket not matching the provided media type
- All files in target folder that match the provided media type will be submitted to AWS Transcribe
- If you wish to use a custom vocabulary you must have already created it inside the AWS Transcribe console

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
### After custom parameters are set in the file simply make it executable and run the script at the command line
```
~>:  chmod +x queue-transcribe.sh
~>:  ./queue-transcribe.sh
```

#### After completion of the script you can check your transcription job progress within the AWS Transcribe Console
- https://console.aws.amazon.com/transcribe/
