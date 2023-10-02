#!/bin/bash

jq -c '.[]' tweet/tweets.json | while read tweet_id; do
    # Run the tweet_request.sh script with the tweet_id as an argument
    # Pipe the output to jq for parsing
    # Redirect the output to a [tweet_id].json file
    bash tweet_request.sh "$tweet_id" > temp
    echo temp
    cat temp | jq --arg tweet_id "$tweet_id" '.. | objects | select(.__typename=="Tweet" and .rest_id==env.tweet_id) | .legacy.full_text' > "tweet/$tweet_id.json"
done
