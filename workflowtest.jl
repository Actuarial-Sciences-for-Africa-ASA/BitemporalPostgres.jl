using SearchLight
using SearchLightPostgreSQL
SearchLight.Configuration.load() |> SearchLight.connect
SearchLight.Migrations.create_migrations_table()
SearchLight.Migrations.up()
using BitemporalPostgres, Dates, SearchLight, Test, TimeZones
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
@testset "create entity" begin
    @test w1.is_committed == 0
    @test w1.ref_version == tr.ref_validfrom
    @test w1.ref_version == tsr.ref_validfrom
end
#=
committing w1 blue rectangle
=#
@testset "commit create entity" begin
    commit_workflow!(w1)
    @test w1.is_committed == 1
end
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
@testset "update entity" begin
    @test w2.ref_version == tr2.ref_validfrom
    @test w2.ref_version == tr.ref_invalidfrom
end
#=
committing w2 yellow rectangle
=#
commit_workflow!(w2)
@testset "commit update entity" begin
    @test w2.is_committed == 1
end
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
delete_component!(ts, w3)
tsr = find(TestDummySubComponentRevision, SQLWhereExpression("id=?", 1))[1]
println(tr3)
@testset "retrospective update entity " begin
    @test w3.ref_version == tr3.ref_validfrom
    @test w3.ref_version == tr2.ref_invalidfrom
    @test w3.ref_version == tsr.ref_invalidfrom
end
#= committing w3 red rectangle
=#

commit_workflow!(w3)
@testset "commit retrospective update entity " begin
    @test w3.is_committed == 1
end
#=
Testing reading 
=#
@testset "reading tests" begin
    v1 = findversion(w1.ref_history, w1.tsdb_validfrom, w1.tsw_validfrom)

    @test findcomponentrevision(TestDummyComponentRevision, t.id, v1)[1].description ==
          "blue"
    @test findcomponentrevision(TestDummySubComponentRevision, ts.id, v1)[1].description ==
          "green"

    v2 = findversion(w2.ref_history, w2.tsdb_validfrom, w2.tsw_validfrom)

    @test findcomponentrevision(TestDummyComponentRevision, t.id, v2)[1].description ==
          "yellow"
    @test findcomponentrevision(TestDummySubComponentRevision, ts.id, v2)[1].description ==
          "green"

    v2a = findversion(w2.ref_history, w2.tsdb_validfrom, w2.tsw_validfrom - Dates.Second(1))

    @test findcomponentrevision(TestDummyComponentRevision, t.id, v2a)[1].description ==
          "blue"
    @test findcomponentrevision(TestDummySubComponentRevision, ts.id, v2a)[1].description ==
          "green"


    v3 = findversion(w3.ref_history, w3.tsdb_validfrom, w3.tsw_validfrom)

    @test findcomponentrevision(TestDummyComponentRevision, t.id, v3)[1].description ==
          "red"
    @test isempty(findcomponentrevision(TestDummySubComponentRevision, ts.id, v3))

    v3a = findversion(w3.ref_history, w3.tsdb_validfrom, w3.tsw_validfrom - Dates.Second(1))

    @test findcomponentrevision(TestDummyComponentRevision, t.id, v3a)[1].description ==
          "blue"
    @test findcomponentrevision(TestDummySubComponentRevision, ts.id, v3a)[1].description ==
          "green"

end

w4 = Workflow(
    ref_history = w1.ref_history,
    tsw_validfrom = ZonedDateTime(2017, 11, 30, 21, 0, 1, 1, tz"Africa/Porto-Novo"),
)
tr4 = copy(tr3)
tr4.description = "green"
t1=TestDummyComponent()
tr5=TestDummyComponentRevision(description="pink")

# @test tr3.ref_invalidfrom==MaxVersion

update_entity!(w4)
update_component!(tr3, tr4, w4)
println(tr4)
create_component!(t1, tr5, w4)
println(tr5)

@testset "pending transaction tests" begin
    v4=find(Version,SQLWhereExpression("id=?", w4.ref_version))[1].id
    @test findcomponentrevision(TestDummyComponentRevision, t.id, v4)[1].description == "green"
    @test findcomponentrevision(TestDummyComponentRevision, t1.id, v4)[1].description == "pink"
    @test w4.ref_version == tr3.ref_invalidfrom
    @test w4.ref_version == tr4.ref_validfrom
    @test MaxVersion == tr4.ref_invalidfrom
    @test w4.ref_version == tr5.ref_validfrom
end
println(tr4)
println(tr3)

currentVersion = find(Version, SQLWhereExpression("id=?", w4.ref_version))[1]
currentInterval =    find(ValidityInterval, SQLWhereExpression("ref_version=?", w4.ref_version))[1]
tr3b = find(TestDummyComponentRevision,SQLWhereExpression("id=?",tr3.id))[1]
# delete(currentVersion)
rollback_workflow!(w4)
tr3b = find(TestDummyComponentRevision,SQLWhereExpression("id=?",tr3.id))[1]
println(tr3b)
@testset "rollback transaction tests" begin
    @test tr3b.ref_invalidfrom == MaxVersion
    @test findcomponentrevision(TestDummyComponentRevision, t.id, DbId(4))[1].description == "red"
    @test isempty(find(TestDummyComponentRevision, SQLWhereExpression("id=?", tr4.id)))
    @test isempty(find(TestDummyComponent, SQLWhereExpression("id=?", t1.id)))
    @test isempty(find(Version, SQLWhereExpression("id=?", currentVersion.id)))
    @test isempty(find(ValidityInterval, SQLWhereExpression("id=?", currentInterval.id)))


root = find(
    ValidityInterval,
    SQLWhereExpression("ref_history=? AND tsrdb @> now()", w1.ref_history),
)[1]

shadowed = find(
    ValidityInterval,
    SQLWhereExpression(
        "ref_history=? AND tsdb_invalidfrom=? AND tstzrange(?,?) * tsrworld = tsrworld",
        root.ref_history,
        root.tsdb_validfrom,
        root.tsworld_validfrom,
        root.tsworld_invalidfrom,
    )
)

@test ! isempty(shadowed)

end