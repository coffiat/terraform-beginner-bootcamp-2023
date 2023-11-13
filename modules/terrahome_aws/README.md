## Terrahome AWS

```tf
 module "home_payday_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.payday.public_path
  content_version = var.content_version
}
```

The public directory expects the folowing:
-index.html
-error.html
-assets

All top level files in assets will be copied, but not any subdirectories.
