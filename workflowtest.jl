using SearchLight
using SearchLightPostgreSQL
ENV["GENIE_ENV"] = "dev"
run(`psql -f sqlsnippets/droptables.sql`)
SearchLight.Configuration.load() |> SearchLight.connect
SearchLight.Migrations.create_migrations_table()
SearchLight.Migrations.up()
using BitemporalPostgres, Dates,SearchLight,Test,TimeZones
#=
workflow w1 blue rectangle
=#
w1 = Workflow()
w1.tsw_validfrom = ZonedDateTime(2014, 5, 30, 21, 0, 1, 1, tz"Africa/Porto-Novo")
SearchLight.Configuration.load() |> SearchLight.connect
t = TestDummyComponent()
tr = TestDummyComponentRevision(description = "blue")
ts = TestDummySubComponent(ref_super = t.id)
tsr = TestDummySubComponentRevision(description = "green")
create_entity!(w1)
create_component!(t, tr, w1)
println(tr)
create_subcomponent!(t, ts, tsr, w1)
w1.ref_history != Nothing
@test w1.is_committed == 0
@test w1.ref_version == tr.ref_validfrom
@test w1.ref_version == tsr.ref_validfrom
#=
committing w1 blue rectangle
=#
commit_workflow!(w1)
@test w1.is_committed == 1
#=
workflow w2 yellow rectangle overlaps blue one
=#
w2 = Workflow(
    ref_history = w1.ref_history,
    tsw_validfrom = ZonedDateTime(2015, 5, 30, 21, 0, 1, 1, tz"Africa/Porto-Novo"),
)
tr2 = copy(tr)
tr2.description = "yellow"
update_entity!(w2)
update_component!(tr, tr2, w2)
println(tr2)
@test w2.ref_version == tr2.ref_validfrom
@test w2.ref_version == tr.ref_invalidfrom
#=
committing w2 yellow rectangle
=#
commit_workflow!(w2)
@test w2.is_committed == 1
#=
workflow w3 red rectangle shadows red and overlaps blue one
=#
w3 = Workflow(
    ref_history = w1.ref_history,
    tsw_validfrom = ZonedDateTime(2014, 11, 30, 21, 0, 1, 1, tz"Africa/Porto-Novo"),
)
tr3 = copy(tr2)
tr3.description = "red"
update_entity!(w3)
update_component!(tr2, tr3, w3)
println(tr3)
@test w3.ref_version == tr3.ref_validfrom
@test w3.ref_version == tr2.ref_invalidfrom
delete_component!(ts,w3)
#=
committing w3 yelredlow rectangle
=#
commit_workflow!(w3)
@test w3.is_committed == 1
#=
Testing reading 
=#
@testset "reading tests" begin
v1 = findversion(w1.ref_history, w1.tsdb_validfrom, w1.tsw_validfrom)

@test findcomponentrevision(TestDummyComponentRevision, t.id, v1)[1].description == "blue"
@test findcomponentrevision(TestDummySubComponentRevision, ts.id, v1)[1].description == "green"

v2 = findversion(w2.ref_history, w2.tsdb_validfrom, w2.tsw_validfrom)

@test findcomponentrevision(TestDummyComponentRevision, t.id, v2)[1].description == "yellow"
@test findcomponentrevision(TestDummySubComponentRevision, ts.id, v2)[1].description == "green"

v2a = findversion(w2.ref_history, w2.tsdb_validfrom, w2.tsw_validfrom - Dates.Second(1))

@test findcomponentrevision(TestDummyComponentRevision, t.id, v2a)[1].description == "blue"
@test findcomponentrevision(TestDummySubComponentRevision, ts.id, v2a)[1].description == "green"


v3 = findversion(w3.ref_history, w3.tsdb_validfrom, w3.tsw_validfrom)

@test findcomponentrevision(TestDummyComponentRevision, t.id, v3)[1].description == "red"
@test isempty(findcomponentrevision(TestDummySubComponentRevision, ts.id, v3))

v3a = findversion(w3.ref_history, w3.tsdb_validfrom, w3.tsw_validfrom - Dates.Second(1))

@test findcomponentrevision(TestDummyComponentRevision, t.id, v3a)[1].description == "blue"
@test findcomponentrevision(TestDummySubComponentRevision, ts.id, v3a)[1].description == "green"

end