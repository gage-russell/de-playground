# make kind-cluster
# make set-context
# make lock-localstack
# make release-localstack
# kubectl port-forward <pod> 4566:4566
# cd aws-local-files

# file/dir name duplication
awslocal s3api create-bucket --bucket my-bucket;
awslocal s3 cp ./foo.txt s3://my-bucket/foo.txt;
awslocal s3 cp ./foo.txt s3://my-bucket/foo.txt/foo.txt;
awslocal s3 ls s3://my-bucket --recursive;

# object tagging
awslocal s3api put-object-tagging --bucket my-bucket --key foo.txt --tagging "{\"TagSet\": [{\"Key\": \"department\", \"Value\": \"accounting\"}]}";
awslocal s3api get-object-tagging --bucket my-bucket --key foo.txt;

# triggered lambda
awslocal lambda create-function --function-name my-lambda --handler python-lambda-zip.test_lambda.lambda_handler --runtime python3.9 --zip-file fileb://python-lambda-zip.zip --role arn:aws:iam::000000000000:role/lambda-role;
awslocal s3api put-bucket-notification-configuration --bucket my-bucket --notification-configuration file://s3-notif-config.json;
awslocal s3 cp ./foo.txt s3://my-bucket/test-triggers/foo.txt;
awslocal logs tail '/aws/lambda/my-lambda';

# cd ../
# make cleanup
