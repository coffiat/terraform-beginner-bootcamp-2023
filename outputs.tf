output "bucket_name" {
  description = "bucket name for our static website"
  value = module.terrahouse-aws.bucket_name
}

output "s3_website_endpoint" {
  description = "s3 static website hosting endpoint"
  value = module.terrahouse-aws.website_endpoint
}