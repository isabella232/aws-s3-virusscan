#!/bin/bash
TEMPLATE_LOCAL="${1}"
TEMPLATE_FILE=$(basename ${TEMPLATE_LOCAL})
STACK_NAME="${2}"
OWNER="${3}"
PROFILE="${4}"

aws s3 cp "${TEMPLATE_LOCAL}" "s3://cf-templates-jobber-dev/${TEMPLATE_FILE}" --content-type application/x-zip --sse
aws cloudformation create-stack --stack-name "${STACK_NAME}" --template-url "https://cf-templates-jobber-dev.s3.amazonaws.com/${TEMPLATE_FILE}" --capabilities CAPABILITY_NAMED_IAM --tags "Key=environment,Value=staging" "Key=owner,Value=${OWNER}" --parameters "ParameterKey=ParentVPCStack,ParameterValue=vpc-virus-scan" "ParameterKey=S3BucketRestriction,ParameterValue=*" "ParameterKey=S3ObjectRestriction,ParameterValue=*" "ParameterKey=DeleteInfectedFiles,ParameterValue=false" "ParameterKey=ReportCleanFiles,ParameterValue=false" "ParameterKey=TagFiles,ParameterValue=true" "ParameterKey=TagKey,ParameterValue=clamavx" "ParameterKey=AutoScalingMinSize,ParameterValue=1" "ParameterKey=AutoScalingMaxSize,ParameterValue=5" "ParameterKey=InstanceType,ParameterValue=t2.small" "ParameterKey=WhitelistedMimeTypes,ParameterValue='image/*,video/mp4'"
