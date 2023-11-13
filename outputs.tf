output "bucket_name" {
  description = "bucket name for our static website"
  value       = module.home_dragon-ball_hosting.bucket_name
}

output "s3_website_endpoint" {
  description = "s3 static website hosting endpoint"
  value       = module.home_dragon-ball_hosting.website_endpoint
}


output "cloudfront_url" {
  description = "The cloudfront Distribution Domain name"
  value       = module.home_dragon-ball_hosting.domain_name
}