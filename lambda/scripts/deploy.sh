# ディレクトリ情報の取得
CURRENT_PATH=$(cd $(dirname $0); pwd)
ROOT_PATH=$CURRENT_PATH/..

# pythonパッケージのインストール
pip install --target ./package -r $ROOT_PATH/requirements.txt --system

# pythonパッケージのzip化
cd package
zip ../deployment-package.zip -r ./*
cd ..

# ソースコードをzipファイルに追加
zip -g deployment-package.zip -j $ROOT_PATH/src/main.py

# S3にアップロードしてlambda関数の参照を書き換える
aws s3 cp ./deployment-package.zip s3://okamoto-tf-test-bucket/
aws lambda update-function-code --function-name lambda_test --s3-bucket okamoto-tf-test-bucket --s3-key deployment-package.zip

# デプロイ時の一時ファイルを削除
rm deployment-package.zip
rm -r package
