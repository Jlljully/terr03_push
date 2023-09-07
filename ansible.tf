resource "local_file" "ansible_inventory" {
  filename = "./inventory.yml"
  content  = templatefile("ansible.tftpl", {
    webservers = yandex_compute_instance.ubuntu,
    databases  = yandex_compute_instance.bubuntu,
    storage    = yandex_compute_instance.storage,
  })
}
