resource "google_compute_network" "basenetwork" {
  name                    = "${var.prefix}-base-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "basesubnetwork" {
  name          = "${var.prefix}-base-subnetwork"
  ip_cidr_range = "10.0.0.0/24"
  network       = google_compute_network.basenetwork.self_link
  region        = var.region
}

module "gce-lb-http" {
  source  = "GoogleCloudPlatform/lb-http/google"
  version = "~> 4.4"

  project     = var.project
  name        = "${var.prefix}-http-lb"
  target_tags = ["allow-lb-service"]
  backends = {
    default = {
      description            = null
      protocol               = "HTTP"
      port                   = 80
      port_name              = "http"
      timeout_sec            = 10
      enable_cdn             = false
      custom_request_headers = null
      security_policy        = null

      connection_draining_timeout_sec = null
      session_affinity                = null
      affinity_cookie_ttl_sec         = null

      health_check = {
        check_interval_sec  = null
        timeout_sec         = null
        healthy_threshold   = null
        unhealthy_threshold = null
        request_path        = "/"
        port                = 80
        host                = null
        logging             = null
      }

      log_config = {
        enable      = true
        sample_rate = 1.0
      }

      groups = [
        {
          group                        = google_compute_instance_group_manager.igm.instance_group
          balancing_mode               = null
          capacity_scaler              = null
          description                  = null
          max_connections              = null
          max_connections_per_instance = null
          max_connections_per_endpoint = null
          max_rate                     = null
          max_rate_per_instance        = null
          max_rate_per_endpoint        = null
          max_utilization              = null
        },
      ]

      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }
    }
  }
}