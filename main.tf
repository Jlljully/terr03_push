resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "null_resource" "web_hosts_provision" {
depends_on = [yandex_compute_instance.ubuntu, yandex_compute_instance.bubuntu, yandex_compute_instance.storage]

 provisioner "local-exec" {
    command = "sleep 60"
  }

  provisioner "local-exec" {                  
    command  = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/inventory.yml ${abspath(path.module)}/test.yml"
    on_failure = continue
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
   
  }
    triggers = {  
      always_run         = "${timestamp()}" 
      playbook_src_hash  = file("${abspath(path.module)}/test.yml") 
      ssh_public_key     = var.metadata.ssh-keys
    }

}
