#!/bin/bash

# Check if argument is passed
if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    echo "Please provide the following arguments:"
    echo "1st argument: The number of times the loop should run"
    echo "2nd argument (optional): The cursor position to start from"
    exit 1
fi

# If a second argument is passed, skip the initial steps and start with the loop
if [ $# -gt 1 ]; then
    echo $2 > cursor.txt
else
    # Run bash timeline_request.sh
    bash timeline_request.sh

    # Run bash parse_timeline.sh timeline/1st.json > cursor.txt
    bash parse_timeline.sh timeline/1st.json > cursor.txt
fi

# Initialize counter
counter=0

# Start loop
while [ $counter -lt $1 ]; do
    # Run bash timeline_request.sh $(cat cursor.txt)
    bash timeline_request.sh $(cat cursor.txt)

    # Run bash parse_timeline.sh timeline/$(cat cursor.txt) > cursor.txt
    bash parse_timeline.sh timeline/$(cat cursor.txt).json > cursor.txt

    # Increment the counter
    ((counter++))
done

# After the loop completes, concatenate all files in the tweet/ directory, remove quotes, and parse as a JSON array
rm -f tweet/tweets.json
cat tweet/*.json > tweets.json
rm tweet/*.json
jq -R -s -c 'gsub("\""; "") | split("\n")[:-1]' tweets.json > tweet/tweets.json
rm tweets.json

# Download all the details for the tweet ids in tweets.json
bash get_tweets.sh
