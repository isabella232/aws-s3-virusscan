Building

Remember to setup AWS CLI with:
aws sts get-session-token --profile "johnz" --serial-number arn:aws:iam::275552769658:mfa/john.z --token-code 12344567

(use your MFA ARN (found in AWS User Console) and MFA token code above). Don't forget --profile if using multiple CLI profiles

run:
make stack (for prod)
make stack_staging (for staging env)


After build:
Add an S3 event going to the SQS queue that would have been created above.
Add an email address to SNS topic created above

Enable auto_scaling_groups metrics
Rebuild dashboard

Look into tags, can we tag the EC2 servers so the tag shows up in billing explore?

