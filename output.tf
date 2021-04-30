output "id" {
  value = aws_s3_bucket.test_bucket.id
}
output "arn" {
  value = aws_s3_bucket.test_bucket.arn
}
output "bucket_domain_name" {
  value = aws_s3_bucket.test_bucket.bucket_domain_name
}
output "bucket_regional_domain_name" {
  value = aws_s3_bucket.test_bucket.bucket_regional_domain_name
}
output "hosted_zone_id" {
  value = aws_s3_bucket.test_bucket.hosted_zone_id
}
output "region" {
  value = aws_s3_bucket.test_bucket.region
}
output "website_endpoint" {
  value = aws_s3_bucket.test_bucket.website_endpoint
}
output "website_domain" {
  value = aws_s3_bucket.test_bucket.website_domain
}

output "aws_s3_bucket_object_id" {
  value = aws_s3_bucket_object.lambda_file.id
}

output "aws_s3_bucket_object_etag" {
  value = aws_s3_bucket_object.lambda_file.etag
}

output "aws_s3_bucket_object_version_id" {
  value = aws_s3_bucket_object.lambda_file.version_id
}
