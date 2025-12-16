terraform {
  backend "gcs" {
    bucket = "streamquest-terraform-states"
    prefix = "streamquest"
  }
}
