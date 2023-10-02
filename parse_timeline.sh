#!/bin/bash

if [ $# -eq 0 ]
then
  echo "No arguments supplied. Please provide a JSON file."
  exit 1
fi

FILE=$1

if [ ${FILE: -5} != ".json" ]
then
  echo "Invalid file type. Please provide a JSON file."
  exit 1
fi

if [ ! -f $FILE ]
then
  echo "File not found!"
  exit 1
fi

TIMELINE=$(cat $FILE)
ENTRIES=$( echo $TIMELINE | jq '.data.user.result.timeline_v2.timeline.instructions[] | select(.type=="TimelineAddEntries") | .entries' )
CURSOR_VALUE=$( echo $ENTRIES | jq -r '.[-1].content.value' )

if [ ! -d "tweets" ]; then
  mkdir tweets
fi

TWEET_IDS=$(echo $TIMELINE | jq '.. | objects | select(.__typename=="Tweet") | .rest_id')
FILENAME=$(basename "$FILE" .json)
mkdir -p tweet
OUTPUT_FILE="tweet/${FILENAME}.json"
echo $TWEET_IDS | jq . > $OUTPUT_FILE

echo $CURSOR_VALUE
