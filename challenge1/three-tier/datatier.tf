resource "google_sql_database_instance" "master" {
  name             = "${var.prefix}-master-instance"
  database_version = "POSTGRES_11"
  region           = var.region

  settings {
    tier = var.data_tier_machinetype
  }
}