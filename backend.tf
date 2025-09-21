terraform {
  backend "gcs" {
    bucket = "streamquest-472309-terraform-states"
    prefix = "streamquest"
  }
}
