admin = db.getSiblingDB("admin")
admin.createUser(
  {
    user: "user_name",
    pwd:  "password",     // or cleartext password
    roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
  }
)
db.getSiblingDB("admin").auth("user_name", "password")
db.getSiblingDB("admin").createUser(
  {
    "user" : "config_user",
    "pwd" : "password2",     // or cleartext password
    roles: [ { "role" : "clusterAdmin", "db" : "admin" } ]
  }
)
db.getSiblingDB("admin").createUser(
  {
    "user" : "my_db_user",
    "pwd" : "password3",     // or cleartext password
    roles: [ { "role" : "readWrite", "db" : "my_db" } ]
  }
)
