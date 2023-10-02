#!/bin/bash

# The file to be processed
FILE_NAME="original_tweet_request.sh"

# Check if argument is provided
if [ -z "$1" ]
then
    echo "No argument supplied"
    exit 1
fi

# Check if the file exists
if [ ! -f "$FILE_NAME" ]
then
    echo "File not found: $FILE_NAME"
    exit 1
fi

# URL encode the TWEET_ID
TWEET_ID=$(echo -n "$1" | curl -Gso /dev/null -w %{url_effective} --data-urlencode @- "" | cut -c 3-)

# The generic string pattern to be replaced
SEARCH_PATTERN="focalTweetId%22%3A%22[0-9]*%22"

# Process the content of the file and store it in a variable
MODIFIED_CONTENT=$(sed "s/${SEARCH_PATTERN}/focalTweetId%22%3A%22${TWEET_ID}%22/g" "$FILE_NAME")

# Check if the sed command was successful
if [ $? -ne 0 ]
then
    echo "Error processing file: $FILE_NAME"
    exit 1
fi

# Execute the modified content as a bash script
eval "$MODIFIED_CONTENT"
