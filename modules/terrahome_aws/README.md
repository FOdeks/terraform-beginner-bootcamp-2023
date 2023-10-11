## Terrahome AWS

A module named **Terrahome AWS**, was developed for the TerraTowns. This module included two nested modules:

- **Storage** - `resource-storage.tf` 

  AWS Caller Identity

  Static Website Hosting

  S3 Bucket

  Bucket Policy

- **Content Delivery Network** - `resource-cdn.tf`

  Origin Access Controls

  CloudFront Distribution (incorporated a code to invalidate Cache)
  
The module was called in the root module, `main.tf` as follows:

```tf
module "home_smoothjazz_hosting" {
  source          = "./modules/terrahome_aws"
  user_uuid       = var.teacherseat_user_uuid
  public_path     = var.smoothjazz.public_path
  content_version = var.smoothjazz.content_version
}
```

The public directory expects the following:
- index.html
- error.html
- assets

All top level files in `assets` will be copied, but not the subdirectories.
