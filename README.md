# twitter-whisperer
bop it, twist it, scrape it

## Huh?
Get that tasty X data without genuflecting at the altar of Musk!!!

## Installation
```bash
git clone https://github.com/notarussianteenager/twitter-whisperer
cd twitter-whisperer
```

## Usage
Follow these steps, midwit Western noob:

1. Go to x.com
2. Make sure you're logged in
3. Go to the feed of the person of interest
4. Right-click on one of their Tweets
5. Click inspect to open dev tools
6. Switch to the "Network" tab
7. Cmd + R or Ctrl + R
8. Type "UserTweets" into the "Filter" box
9. Right-click on the bottom result
10. Copy -> Copy as cURL
11. cd to twitter-whisperer
12. Paste into `original_timeline_request.sh`
13. Now, left-click on one of their Tweets to expand it
14. Enter "TweetDetail" into the "Filter" box
15. Right-click on the bottom result
16. Copy -> Copy as cURL
17. Paste into `original_tweet_request.sh`
18. Run `bash download.sh {number of iterations here, e.g 25}`

Done!
