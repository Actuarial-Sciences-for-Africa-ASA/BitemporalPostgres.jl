run(`psql -f sqlsnippets/droptables.sql`)
using SearchLight
using SearchLightPostgreSQL
SearchLight.Configuration.load() |> SearchLight.connect
SearchLight.Migrations.create_migrations_table()
SearchLight.Migrations.up()