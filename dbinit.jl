run(`psql -f sqlsnippets/droptables.sql`)
using SearchLight
using SearchLightPostgreSQL
SearchLight.connect(SearchLight.Configuration.load())
SearchLight.Migrations.create_migrations_table()
SearchLight.Migrations.up()