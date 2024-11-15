#!/usr/bin/env bash

start=`date +%s`

# Touch the index.js file
echo '// foo' >> index.js

echo "Zipping the code..."
zip -q code.zip index.js

echo "Uploading the code to S3..."
aws s3 cp code.zip s3://tmp-bref-deploy-bucket/code.zip

echo "Creating a new version of the function..."
VERSION=$(aws lambda update-function-code --function-name tmp-bref-deploy --s3-bucket tmp-bref-deploy-bucket --s3-key code.zip --publish --output json | jq -r .Version)
echo "Created version $VERSION"

# Wait for the update to finish
while [ "$(aws lambda get-function --function-name tmp-bref-deploy:$VERSION --query 'Configuration.State' --output json)" != '"Active"' ]; do
    echo "Waiting for the new version to be ready..."
    sleep 1
done

echo "The new version is now active."

# ...

echo "Switching the alias 'main' to the new version..."
aws lambda update-alias --function-name tmp-bref-deploy --name main --function-version $VERSION --output json

end=`date +%s`
runtime=$((end-start))
echo "Deployed in $runtime seconds"
echo ""

# CloudFormation deploy
#aws cloudformation deploy --template-file template.yml --stack-name tmp-bref-deploy --region us-east-1 --capabilities CAPABILITY_IAM

echo "Invoking the function..."
curl https://pjj4ds77ckwln7soauk5sas4zq0xojpy.lambda-url.us-east-1.on.aws/
echo ""
