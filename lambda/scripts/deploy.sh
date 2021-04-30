CURRENT_PATH=$(cd $(dirname $0); pwd)
ROOT_PATH=$CURRENT_PATH/..

pip install --target ./package -r $ROOT_PATH/requirements.txt
zip -r deployment-package.zip ./package
zip -g deployment-package.zip -j $ROOT_PATH/src/main.py

# update lambda
aws s3 cp ./deployment-package.zip s3://okamoto-tf-test-bucket/
aws lambda update-function-code --function-name lambda_test --s3-bucket okamoto-tf-test-bucket --s3-key deployment-package.zip

# sweep workspace
rm deployment-package.zip
rm -r package
