project_id = "streamquest-prod"
region     = "europe-west1"
app_name   = "orders"
repo_id    = "orders"

env = "prod"

allow_unauthenticated = false

db = {
  instance_name = "orders-prod"
  db_name       = "appdb"
  db_user       = "appuser"
  db_password   = "CHANGE_ME_PROD"
  version       = "MYSQL_8_0"
  tier          = "db-custom-1-3840"
}
