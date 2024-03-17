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
        sang:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCf697dPsIo62xz55e0JFHe0//k1JDbCfH9MV7y+W4g3EWPvK3Zu3woztMS/9aSUupoeKkIsaMdSftb5jQazI21/mrBbPc0rgPhUgXFXom2Vm0m0kCClX/YW6FxZ/796P/RsZO/Wmu4upjeTUhyhTWhSHSrtPu6pWmpmi0Nzk8HOHLv+PHGceeiFwEQqNu5XBqEiVdHH5yDrnL9UdRXLFKSQLR1mQdj8qvCrzTbGtTkuwyZAVmqCeQIYPq2AjcNlGPa6tzDUExlS1C4o7Cp7yZU7CyMTzLoNtdqcXnDpDkf0I3Id7I8H9NN7icCsGpFqBrGsL9pccN9bJ7vGMtdizQKlYq2EIrY2JRMxD5vJVq6BMhxeXkl4FkIgEVr3/AiWWPd4NKKknDRMdZjkllgvvGBEqO7SoeUrjq2UbLgwm0yTyufw6dR9LumVFjxryxGDYs88H9I24CHXojEsZ/HynvnqOXxa/HeQY3UEM7WT2sEc2bJ5lpe8jCJhLapBWZDok9IFsf5oc8W9hZ67Qvfn0gTCNqtZiZ5k/hX/BVUI47TxwyxfT7w1hBH8lTqqNUOBpGLOqGIQNGgTvvlQAE7aBro1mPtgWfuIwUD/hJT7fIiQzSOkXRKVOlPEwTe9lWk/hQZAfd4X0Tmi7y8RVZc1JOfFhCld6Vddh6ZVfdY1c0b2Q== sang@Nguyens-MacBook-Pro.local
     EOT
  }
}
