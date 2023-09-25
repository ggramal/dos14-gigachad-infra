#!/bin/bash
read -p 'Enter your MFA token: ' token
read -p 'Enter profile name: ' profile
read -p 'Enter mfa name: ' mfa
export AWS_PROFILE=$profile
accountID=$( aws sts get-caller-identity --profile $profile | jq -r '.Account')
json=$( aws sts assume-role --role-arn arn:aws:iam::$accountID:role/Admins \
--role-session-name tf \
--serial-number arn:aws:iam::$accountID:mfa/$mfa \
--token-code $token \
--profile $profile)
eval $(echo  $json | jq -r '.Credentials | "AccessKeyId=\(.AccessKeyId)","SecretAccessKey=\(.SecretAccessKey)","SessionToken=\(.SessionToken)"')
export AWS_ACCESS_KEY_ID=$AccessKeyId
export AWS_SECRET_ACCESS_KEY=$SecretAccessKey
export AWS_SESSION_TOKEN=$SessionToken
