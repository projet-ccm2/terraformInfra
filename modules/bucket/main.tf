resource "google_storage_bucket" "this" {
  name                        = var.bucket_name
  location                    = var.region
  uniform_bucket_level_access = true
  versioning { 
    enabled = var.enable_versioning 
  }
  lifecycle_rule {
    action { type = "Delete" }
    condition { age = 90 }
  }
}

output "name" { value = google_storage_bucket.this.name }
