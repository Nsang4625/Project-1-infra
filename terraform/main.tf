provider "google" {
  project     = "terraform-make-3vms"
  credentials = file("terraform-make-3vms-6b283ec2f7ed.json")
  region      = "us-central1"
  zone        = "us-central1-c"
}

resource "google_compute_instance" "controller_instance" {
  name         = "controller${count.index + 1}"
  machine_type = "e2-standard-2"
  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20240229"
      type  = "pd-standard"
      size  = "25"
    }
    auto_delete = true
  }
  network_interface {
    network = "default"
  }
  scheduling {
    preemptible        = true
    provisioning_model = "SPOT"
    automatic_restart  = false
  }
  metadata = {
    "ssh-keys" = <<EOT
     EOT
  }
  count = 2
}



resource "google_compute_instance" "master_instance" {
  name         = "master"
  machine_type = "e2-standard-2"
  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20240229"
      type  = "pd-standard"
      size  = "25"
    }
    auto_delete = true
  }
  network_interface {
    network = "default"
    access_config {

    }
  }
  scheduling {
    preemptible        = true
    provisioning_model = "SPOT"
    automatic_restart  = false
  }
  metadata = {
    "ssh-keys" = <<EOT
     EOT
  }
}
