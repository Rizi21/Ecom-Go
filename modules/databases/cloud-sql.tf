# Create a Cloud SQL instance
resource "google_sql_database_instance" "my_db_instance" {
  name             = "my-db-instance"
  database_version = "POSTGRES_15"  # Change to your desired database version
  region           = var.region
  project          = var.project_id
  deletion_protection = false

  settings {
    tier = "db-f1-micro" /* "db-custom-2-7680"   */# Adjust the tier and resources as needed
  

    # Associate the database with the private subnet
 
    ip_configuration {
      ipv4_enabled    = true
      private_network = var.google_compute_network
      require_ssl    = true
    }
  }
}

# Create a SQL database 
resource "google_sql_database" "ecom_db" {
  name     = "products_db"
  instance = google_sql_database_instance.my_db_instance.name
  project          = var.project_id
}

# Create DB user
resource "google_sql_user" "ecom-user" {
  name = "admin"
  instance = google_sql_database_instance.my_db_instance.id
  password = "Welcome123"
  project = "riz-go"
}




# # Create tables in the database
# resource "google_sql_database_instance" "my_db_instance" {
#   depends_on = [google_sql_database.ecom_db]

#   name             = google_sql_database_instance.my_db_instance.name
#   database_version = google_sql_database_instance.my_db_instance.database_version
#   region           = google_sql_database_instance.my_db_instance.region
#   project          = google_sql_database_instance.my_db_instance.project

#   settings {
#     tier = google_sql_database_instance.my_db_instance.settings[0].tier
#   }

  # Associate the database with the private subnet
#   network_settings {
#     ip_configuration {
#       ipv4_enabled    = true
#       private_network = google_sql_database_instance.my_db_instance.network_settings[0].ip_configuration[0].private_network
#       require_ssl    = true
#     }
#   }
# }

# Create a "products" table in the database
# resource "google_sql_table" "products_table" {
#   name     = "products"
#   database = google_sql_database.ecom_db.name
#   instance = google_sql_database_instance.my_db_instance.name

#   column {
#     name    = "product_id"
#     type    = "INT64"
#     not_null = true
#   }

#   column {
#     name = "product_name"
#     type = "STRING"
#   }

#   # Define other columns as needed for your "products" table
# }

# # Create an "orders" table in the database
# resource "google_sql_table" "orders_table" {
#   name     = "orders"
#   database = google_sql_database.ecom_db.name
#   instance = google_sql_database_instance.my_db_instance.name

#   column {
#     name    = "order_id"
#     type    = "INT64"
#     not_null = true
#   }

#   column {
#     name = "customer_id"
#     type = "INT64"
#   }

#   # Define other columns as needed for your "orders" table
# }

# # Create a "stock" table in the database
# resource "google_sql_table" "stock_table" {
#   name     = "stock"
#   database = google_sql_database.ecom_db.name
#   instance = google_sql_database_instance.my_db_instance.name

#   column {
#     name    = "product_id"
#     type    = "INT64"
#     not_null = true
#   }

#   column {
#     name = "quantity"
#     type = "INT64"
#   }

#   # Define other columns as needed for your "stock" table
# }