#!/bin/bash

# Execute the aws sts assume-role command and store the output in a variable
output=$(aws sts assume-role --role-arn arn:aws:iam::546240550610:role/Admins --role-session-name tf --serial-number <your_mfa_id> --token-code <your_token_code> --profile <your_profile>)

# Parse the output to extract the values of AccessKeyId, SecretAccessKey, SessionToken
access_key=$(echo "$output" | jq -r '.Credentials.AccessKeyId')
secret_key=$(echo "$output" | jq -r '.Credentials.SecretAccessKey')
session_token=$(echo "$output" | jq -r '.Credentials.SessionToken')

# Export the values as environment variables
export AWS_ACCESS_KEY_ID="$access_key"
export AWS_SECRET_ACCESS_KEY="$secret_key"
export AWS_SESSION_TOKEN="$session_token"