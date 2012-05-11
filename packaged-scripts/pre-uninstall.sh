#! /bin/bash

echo "shutting down aws-twitter-feed"
/opt/aws-twitter-feed/bin/aws-twitter-feed stop
echo "removing sym links at /etc/init.d/aws-twitter-feed"
rm /etc/init.d/aws-twitter-feed