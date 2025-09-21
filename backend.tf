terraform {
  backend "gcs" {
    bucket = "my-terraform-states"
    prefix = "streamquest"
  }
}
