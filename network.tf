
resource "yandex_vpc_network" "network" {
  description = "Network for the Managed Service for MySQL cluster"
  name        = "network"
}

resource "yandex_vpc_subnet" "subnet-a" {
  description    = "Subnet in the ru-central1-a availability zone"
  name           = "subnet-a"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.network.id}"
  v4_cidr_blocks = ["10.4.0.0/24"]
}

resource "yandex_vpc_subnet" "subnet-b" {
  description    = "Subnet in the ru-central1-a availability zone"
  name           = "subnet-b"
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.network.id}"
  v4_cidr_blocks = ["10.3.0.0/24"]
}

resource "yandex_vpc_security_group" "security-group" {
  description = "Security group for the Managed Service for MySQL cluster"
  network_id  = yandex_vpc_network.network.id

  ingress {
    description    = "Allow connections to the cluster from the Internet"
    protocol       = "TCP"
    port           = local.source_port
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}