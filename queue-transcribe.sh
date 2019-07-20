#!/bin/bash
# Queue up multiple files/jobs for AWS transcribe using a S3 bucket source
######################################

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

# Optional name of custom vocabulary to use - leave value as "" if none
CUSTOM_VOCABULARY=""

# Desired AWS region to create transribe jobs in
AWS_REGION="us-east-1"

######################################

# Create JSON export directory
mkdir -p json

# Get s3 object list as JSON array
if [ "$SUB_FOLDER" == "" ] > /dev/null 2>&1; then
  echo "LOOKING FOR OBJECTS IN PARENT FOLDER"
  ITEMS="$(aws s3api list-objects-v2 --bucket $BUCKET_NAME --prefix $PARENT_FOLDER/)"
  PARSED=$(echo "${ITEMS}" | jq -c '.[]')
else
  echo "LOOKING FOR OBJECTS IN SUB-FOLDER"
  ITEMS="$(aws s3api list-objects-v2 --bucket $BUCKET_NAME --prefix $PARENT_FOLDER/$SUB_FOLDER/)"
  PARSED=$(echo "${ITEMS}" | jq -c '.[]')
fi

# For each Object in list
for row in $(echo "${PARSED}" | jq -c '.[]'); do
  echo "************************************************************"
  _jq() {
      echo ${row} | jq -r ${1}
  }
  
  # Extract Key
  KEY=$(echo $(_jq '.Key'))
  echo "Detected Object:" $KEY
  
  # Validate key matches correct media format
  if [[ "${KEY,,}" == *"$MEDIA_FORMAT"* ]] > /dev/null 2>&1; then
    echo "Key matches media format of $MEDIA_FORMAT... creating transcribe job"
    
    # Generate new JSON for transcription job
    TRIM=$(echo $KEY | cut -d "/" -f 3)
    NAME="transcribe-${TRIM%????}"
    FILE_URL="https://$BUCKET_NAME.s3.amazonaws.com/$KEY"
    if [ "$CUSTOM_VOCABULARY" == "" ] > /dev/null 2>&1; then
      JSON=$(jq  -n \
              --arg key0    "$NAME"                  \
              --arg key1    "$LANGUAGE_CODE"         \
              --arg key2    "$MEDIA_FORMAT"          \
              --arg key3    "$FILE_URL"              \
              '{TranscriptionJobName: $key0, LanguageCode: $key1, MediaFormat: $key2, Media: {MediaFileUri: $key3} }')
    else
      JSON=$(jq  -n \
              --arg key0    "$NAME"                  \
              --arg key1    "$LANGUAGE_CODE"         \
              --arg key2    "$MEDIA_FORMAT"          \
              --arg key3    "$FILE_URL"              \
              --arg key4    "$CUSTOM_VOCABULARY"     \
              '{TranscriptionJobName: $key0, LanguageCode: $key1, MediaFormat: $key2, Media: {MediaFileUri: $key3}, Settings: {VocabularyName: $key4}}')
    fi    
    
    # Write transcribe job JSON to a file
    JSON_FILE="${TRIM%????}.json"
    touch $JSON_FILE
    echo $JSON > $JSON_FILE
  
    # Queue transcription job to AWS transcribe
    aws transcribe start-transcription-job \
     --region $AWS_REGION \
     --cli-input-json file://$JSON_FILE
    # Avoid submitting incomplete JSON 
    sleep 2
    
    # Archive JSON output to folder
    mv $JSON_FILE json/$JSON_FILE
  else
    echo "Key does not match media format of $MEDIA_FORMAT... skipping"
  fi
done

echo "Please verify job status within AWS Transcribe Console"
echo "https://console.aws.amazon.com/transcribe/"
