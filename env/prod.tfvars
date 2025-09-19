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
}

services = {
  auth    = { image = "europe-west1-docker.pkg.dev/streamquest-prod/auth:v1", allow_unauthenticated = false }
  users   = { image = "europe-west1-docker.pkg.dev/streamquest-prod/users:v1", allow_unauthenticated = false }
  orders  = { image = "europe-west1-docker.pkg.dev/streamquest-prod/orders:v1", allow_unauthenticated = false }
}
