project_id = "streamquest-472309"
region     = "europe-west1"
app_name   = "orders"
repo_id    = "orders"

env = "dev"

allow_unauthenticated = true

db = {
  instance_name = "orders-dev"
  db_name       = "appdb"
  db_user       = "appuser"
  db_password   = "CHANGE_ME"
  version       = "MYSQL_8_0"
  tier          = "db-f1-micro"
}

enable_db_backups         = false
enable_bucket_versioning  = false
db_public_ip              = true
db_authorized_networks    = []

