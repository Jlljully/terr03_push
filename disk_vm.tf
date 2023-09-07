
resource "yandex_compute_instance" "storage" {
  count = 1
  name     = "storage"
  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = 5
    }
  }

dynamic secondary_disk {
    for_each = yandex_compute_disk.testdisk[*].id
    content {
       disk_id  = secondary_disk.value
   }
  }

  platform_id = "standard-v2"

  allow_stopping_for_update = true

  depends_on = [yandex_compute_instance.ubuntu, yandex_compute_disk.testdisk]

  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${"ubuntu"}:${file("/root/.ssh/id_ed25519.pub")}"
  }
}

resource "yandex_compute_disk" "testdisk" {
  count = 3
  name  = "${"disk"}${count.index}"
  type  = "network-hdd"
  size  = 1
}

