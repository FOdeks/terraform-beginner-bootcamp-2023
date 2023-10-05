output "bucket_name" {
  description = "Bucket name for static website hosting"
  value       = module.home_smoothjazz_hosting.bucket_name
}

output "s3_website_endpoint" {
  description = "S3 static website hosting endpoint"
  value       = module.home_smoothjazz_hosting.website_endpoint
}

output "cloudfront_url" {
  description = "The CloudFront Distribution Domain Name"
  value       = module.home_smoothjazz_hosting.domain_name
}
