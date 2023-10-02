output "bucket_name" {
  description = "bucket name for our static website"
  value = module.terrahouse-aws.bucket_name
}