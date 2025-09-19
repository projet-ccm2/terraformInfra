project_id = "streamquest-dev"
region     = "europe-west1"
app_name   = "orders"
repo_id    = "orders"        # artifact registry repo name for this app

env = "dev"

allow_unauthenticated = true

db = {
  instance_name = "orders-dev"
  db_name       = "appdb"
  db_user       = "appuser"
  db_password   = "CHANGE_ME"
  version       = "MYSQL_8_0"
  tier          = "db-custom-1-3840"
}

services = {
  auth    = { image = "europe-west1-docker.pkg.dev/streamquest-dev/auth:v1", allow_unauthenticated = false }
  users   = { image = "europe-west1-docker.pkg.dev/streamquest-dev/users:v1", allow_unauthenticated = false }
  orders  = { image = "europe-west1-docker.pkg.dev/streamquest-dev/orders:v1", allow_unauthenticated = false }
}
