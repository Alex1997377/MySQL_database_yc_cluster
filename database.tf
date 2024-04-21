resource "yandex_mdb_mysql_database" "testdb" {
  cluster_id = yandex_mdb_mysql_cluster.mysql-cluster.id
  name       = "User_database"
}

resource "yandex_mdb_mysql_user" "Alex" {
	cluster_id = yandex_mdb_mysql_cluster.mysql-cluster.id
    name       = local.target_user
    password   = local.target_password

    permission {
      database_name = yandex_mdb_mysql_database.testdb.name
      roles         = ["ALL"]
    }

	connection_limits {
	  max_questions_per_hour   = 10000
	  max_updates_per_hour     = 10000
	  max_connections_per_hour = 10000
	  max_user_connections     = 10000
	}
    
	global_permissions = ["PROCESS"]

	authentication_plugin = "SHA256_PASSWORD"
}