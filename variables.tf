###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "metadata" {
  type    = map(string)
  default = { serial-port-enable = "1", ssh-keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID08bAk0mu9NnxuO+QTKCYee5KF2IZsi9DCm8ATi8uzQ root@ycjll.ru-central1.internal" }
}

variable "testfe" {
  type = list(object({ vm_name = string, cpu = number, ram = number, disk = number }))
  default = [
    { vm_name = "main", cpu = 4, ram = 4, disk = 15 },
    { vm_name = "replica", cpu = 2, ram = 2, disk = 10 },
  ]
}

