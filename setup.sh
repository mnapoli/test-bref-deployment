#!/usr/bin/env bash

# Touch the index.js file
echo '// foo' >> index.js

# Zip the code
zip code.zip index.js

# Upload the code to S3
aws s3 cp code.zip s3://tmp-bref-deploy-bucket/code.zip

# CloudFormation deploy
aws cloudformation deploy --template-file template.yml --stack-name tmp-bref-deploy --region us-east-1 --capabilities CAPABILITY_IAM

# Show CloudFormation outputs
aws cloudformation describe-stacks --stack-name tmp-bref-deploy --region us-east-1 --query 'Stacks[0].Outputs' --output table
