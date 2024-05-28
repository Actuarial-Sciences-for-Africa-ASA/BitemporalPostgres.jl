using SearchLight
using SearchLightPostgreSQL
SearchLight.connect(SearchLight.Configuration.load())
SearchLight.query("DROP SCHEMA public CASCADE")
SearchLight.query("CREATE SCHEMA public")
SearchLight.Migrations.create_migrations_table()
SearchLight.Migrations.up()