resource "google_compute_instance_template" "default" {
  name        = "${var.prefix}-apptier-template"
  description = "This template is used to create app tier instances."

  tags = ["allow-lb-service"]

  instance_description = "description assigned to app tier instances"
  machine_type         = var.app_tier_machinetype
  can_ip_forward       = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  disk {
    source_image      = "debian-cloud/debian-9"
    auto_delete       = true
    boot              = true
  }

  network_interface {
    network = "default"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_group_manager" "igm" {
  name               = "${var.prefix}-instance-group-manager"
  version {
    instance_template  = google_compute_instance_template.default.id
  }
  base_instance_name = "${var.prefix}-app-tier-instance"
  zone               = var.zone
  target_size        = var.app_tier_count
}