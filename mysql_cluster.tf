
resource "yandex_mdb_mysql_cluster" "mysql-cluster" {
  description        = "Managed Service for MySQL cluster"
  name               = "mysql-cluster"
  environment        = "PRODUCTION"
  network_id         = yandex_vpc_network.network.id
  version            = local.target_mysql_version
  security_group_ids = [yandex_vpc_security_group.security-group.id]

  resources {
    resource_preset_id = "s2.micro" # 2 vCPU, 8 GB RAM
    disk_type_id       = "network-ssd"
    disk_size          = 16 # GB

  }

  maintenance_window {
      type = "WEEKLY"
      day  = "SAT"
      hour = 12
  }

  mysql_config = {
    sql_mode = local.target_sql_mode
    max_connections = 10
    default_authentication_plugin = "MYSQL_NATIVE_PASSWORD"
    innodb_print_all_deadlocks    = true
  }

  host {
    zone      = "ru-central1-a"
    name      = "na-a"
    subnet_id = yandex_vpc_subnet.subnet-a.id
  }

  host {
    zone      = "ru-central1-a"
    name      = "na-b"
    subnet_id = yandex_vpc_subnet.subnet-a.id
  }

   host {
    zone                    = "ru-central1-b"
    name                    = "nb-a"
    replication_source_name = "na-a"
    subnet_id               = yandex_vpc_subnet.subnet-b.id
  }

  host {
    zone                    = "ru-central1-b"
    name                    = "nb-b"
    replication_source_name = "nb-a"
    subnet_id               = yandex_vpc_subnet.subnet-b.id
  }
}







