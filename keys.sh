#!/bin/bash

read -p "Enter your aws user: " aws_user
read -p 'Enter your MFA token: ' token
read -p 'Enter profile name: ' profile
read -p 'Enter mfa name: ' mfa

caller_identity=$(aws sts --profile $profile get-caller-identity)
AccountID=$(echo "$caller_identity" | jq -r '.Account')

output_aws=$(aws sts assume-role --role-arn arn:aws:iam::"$AccountID":role/Admins --role-session-name "$aws_user"\
 --serial-number arn:aws:iam::"$AccountID":mfa/"$mfa" --token-code "$token" --profile "$profile")

AccessKeyId=$(echo "$output_aws" | jq -r '.Credentials.AccessKeyId')
SecretAccessKey=$(echo "$output_aws" | jq -r '.Credentials.SecretAccessKey')
SessionToken=$(echo "$output_aws" | jq -r '.Credentials.SessionToken')

export AWS_ACCESS_KEY_ID=$AccessKeyId
export AWS_SECRET_ACCESS_KEY=$SecretAccessKey
export AWS_SESSION_TOKEN=$SessionToken
