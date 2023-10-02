#!/bin/bash

# The file to be processed
FILE_NAME="original_timeline_request.sh"

# Check if the file exists
if [ ! -f "$FILE_NAME" ]
then
    echo "File not found: $FILE_NAME"
    exit 1
fi


# Cursor
CURSOR=${1:-""}

CURSOR_SEARCH_PATTERN="%2C%22cursor%22%3A%22[A-Za-z0-9_-]*%22"

# If cursor is not passed, remove the cursor pattern from the file
if [ -z "$CURSOR" ]
then
    MODIFIED_CONTENT=$(cat "$FILE_NAME")
else
    MODIFIED_CONTENT=$(sed "s/${CURSOR_SEARCH_PATTERN}/%2C%22cursor%22%3A%22${CURSOR}%22/g" "$FILE_NAME")
fi

# Check if the sed command was successful
if [ $? -ne 0 ]
then
    echo "Error processing file: $FILE_NAME"
    exit 1
fi

mkdir -p timeline

# If cursor is not non, write output to file with same name as cursor, else write to "1st_timeline.txt"
if [ -n "$CURSOR" ]
then
    bash -c "$MODIFIED_CONTENT" | jq . > "timeline/${CURSOR}.json"
else
    bash -c "$MODIFIED_CONTENT" | jq . > "timeline/1st.json"
fi

