#!/bin/bash
echo "########### Creating profile ###########"
aws configure set aws_access_key_id default_access_key --profile=local
aws configure set aws_secret_access_key default_secret_key --profile=local
aws configure set region us-west-2 --profile=local

echo "########### Listing profile ###########"
aws configure list