resource "yandex_compute_instance" "bubuntu" {
  for_each = { for i in var.testfe : i.vm_name => i }
  name     = each.value.vm_name
  resources {
    cores  = each.value.cpu
    memory = each.value.ram
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = each.value.disk
    }
  }
  platform_id = "standard-v2"

  allow_stopping_for_update = true

  depends_on = [yandex_compute_instance.ubuntu]

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
