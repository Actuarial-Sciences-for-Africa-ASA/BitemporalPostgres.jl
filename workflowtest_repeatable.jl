# content
# Introduction
# connecting to POSTGRES
# creating the db schema
# testing bitemporal crud
# 1. Introduction
# If You start this repo in gitpod, You can open this notebook in vscode and execute the code with julia and postgres up and running https://www.gitpod.io/docs/
# 
# 1.1. connecting to POSTGRES
include("init.jl")
using Logging, SearchLight
using SearchLightPostgreSQL
SearchLight.connect(SearchLight.Configuration.load())
setfield!(SearchLight.config, :log_queries, false)
setfield!(SearchLight.config, :log_level, Logging.Error)

# 2 Starting with workflows
# 2.1 Workflow 1 (the blue rectangle :=) )
# 2.1.1 Starting workflow 1
# inserting component 1 and subcomponent 1.1

using Dates, Test, TimeZones
import BitemporalPostgres
using BitemporalPostgres

w1blue = Workflow(type_of_entity="TestDummyComponent",
    tsw_validfrom=ZonedDateTime(2014, 5, 30, 21, 0, 1, 1, tz"UTC"))

t1 = TestDummyComponent()
t1r1blue = TestDummyComponentRevision(description="blue")
ts = TestDummySubComponent(ref_super=t1.id)
ts1r1green = TestDummySubComponentRevision(description="green")
create_entity!(w1blue)
create_component!(t1, t1r1blue, w1blue)
println(t1r1blue)
create_subcomponent!(t1, ts, ts1r1green, w1blue)
@test !isnothing(w1blue.ref_history)
@test w1blue.is_committed == 0

@test w1blue.ref_version == t1r1blue.ref_validfrom
@test w1blue.ref_version == ts1r1green.ref_validfrom

#2.1.2 Commiting workflow 1
commit_workflow!(w1blue)
@test w1blue.is_committed == 1

#2.2 Workflow 2 ( the yellow rectangle that shortens the blue one)
#2.2.1 Starting workflow 2
#mutating component 1

w2yellow = Workflow(type_of_entity="TestDummyComponent",
    ref_history=w1blue.ref_history,
    tsw_validfrom=ZonedDateTime(2015, 5, 30, 21, 0, 1, 1, tz"UTC"),
)
t1r2yellow = copy(t1r1blue)
t1r2yellow.description = "yellow"
update_entity!(w2yellow)
update_component!(t1r1blue, t1r2yellow, w2yellow)
println(t1r2yellow)
@test w2yellow.ref_version == t1r2yellow.ref_validfrom
@test w2yellow.ref_version == t1r1blue.ref_invalidfrom

# 2.2.2 Committing workflow 2
commit_workflow!(w2yellow)
@test w2yellow.is_committed == 1

# 2.3 workflow 3 (the red rectancle that shadows the yellow one)
# 2.3.1 Starting workflow 3
w3redshadow = Workflow(type_of_entity="TestDummyComponent",
    ref_history=w1blue.ref_history,
    tsw_validfrom=ZonedDateTime(2014, 11, 30, 21, 0, 1, 1, tz"UTC"),
)
update_entity!(w3redshadow)
t1r1blue = findcomponentrevision(TestDummyComponentRevision, t1.id, w3redshadow.ref_version)[1]
t1r3red = copy(t1r1blue)
t1r3red.description = "red"
update_component!(t1r1blue, t1r3red, w3redshadow)
@test w3redshadow.ref_version == t1r3red.ref_validfrom
# .3.4 Committing workflow 3
commit_workflow!(w3redshadow)
@test w3redshadow.is_committed == 1
# 3 Testing
# For each workflow
# 
# as of its intervals valid from points
# as of its intervals db valid from and 1 second before its world validfrom
v1 = findversion(w1blue.ref_history, w1blue.tsdb_validfrom, w1blue.tsw_validfrom)

@test findcomponentrevision(TestDummyComponentRevision, t1.id, v1)[1].description == "blue"

v2 = findversion(w2yellow.ref_history, w2yellow.tsdb_validfrom, w2yellow.tsw_validfrom)

@test findcomponentrevision(TestDummyComponentRevision, t1.id, v2)[1].description == "yellow"

v2a = findversion(w2yellow.ref_history, w2yellow.tsdb_validfrom, w2yellow.tsw_validfrom - Dates.Second(1))

@test findcomponentrevision(TestDummyComponentRevision, t1.id, v2a)[1].description == "blue"

v3 = findversion(w3redshadow.ref_history, w3redshadow.tsdb_validfrom, w3redshadow.tsw_validfrom)

@test findcomponentrevision(TestDummyComponentRevision, t1.id, v3)[1].description == "red"

v3a = findversion(w3redshadow.ref_history, w3redshadow.tsdb_validfrom, w3redshadow.tsw_validfrom - Dates.Second(1))

@test findcomponentrevision(TestDummyComponentRevision, t1.id, v3a)[1].description == "blue"
v1 = findversion(w1blue.ref_history, w1blue.tsdb_validfrom, w1blue.tsw_validfrom)
r1 = findcomponentrevision(TestDummySubComponentRevision, ts.id, v1)
@testset "reading tests" begin
    v1 = findversion(w1blue.ref_history, w1blue.tsdb_validfrom, w1blue.tsw_validfrom)

    @test findcomponentrevision(TestDummyComponentRevision, t1.id, v1)[1].description == "blue"
    @test findcomponentrevision(TestDummySubComponentRevision, ts.id, v1)[1].description == "green"

    v2 = findversion(w2yellow.ref_history, w2yellow.tsdb_validfrom, w2yellow.tsw_validfrom)

    @test findcomponentrevision(TestDummyComponentRevision, t1.id, v2)[1].description == "yellow"
    @test findcomponentrevision(TestDummySubComponentRevision, ts.id, v2)[1].description == "green"

    v2a = findversion(w2yellow.ref_history, w2yellow.tsdb_validfrom, w2yellow.tsw_validfrom - Dates.Second(1))

    @test findcomponentrevision(TestDummyComponentRevision, t1.id, v2a)[1].description == "blue"
    @test findcomponentrevision(TestDummySubComponentRevision, ts.id, v2a)[1].description == "green"


    v3 = findversion(w3redshadow.ref_history, w3redshadow.tsdb_validfrom, w3redshadow.tsw_validfrom)

    @test findcomponentrevision(TestDummyComponentRevision, t1.id, v3)[1].description == "red"
    @test findcomponentrevision(TestDummySubComponentRevision, ts.id, v3)[1].description == "green"

    v3a = findversion(w3redshadow.ref_history, w3redshadow.tsdb_validfrom, w3redshadow.tsw_validfrom - Dates.Second(1))

    @test findcomponentrevision(TestDummyComponentRevision, t1.id, v3a)[1].description == "blue"
    @test findcomponentrevision(TestDummySubComponentRevision, ts.id, v3a)[1].description == "green"

end
# Testing pending transactions and rollback

w4PendingRollback = Workflow(type_of_entity="TestDummyComponent",
    ref_history=w1blue.ref_history,
    tsdb_validfrom=now(tz"UTC"),
    tsw_validfrom=ZonedDateTime(2017, 11, 30, 21, 0, 1, 1, tz"UTC"),
)
update_entity!(w4PendingRollback)

t1r3red = findcomponentrevision(TestDummyComponentRevision, t1.id, w4PendingRollback.ref_version)[1]
t1r4green = copy(t1r3red)
t1r4green.description = "green"

t2 = TestDummyComponent()
t2r1pink = TestDummyComponentRevision(description="pink")

@test t1r3red.ref_invalidfrom == MaxVersion
update_component!(t1r3red, t1r4green, w4PendingRollback)
create_component!(t2, t2r1pink, w4PendingRollback)
@testset "pending transaction tests" begin
    @test findcomponentrevision(TestDummyComponentRevision, t1.id, w4PendingRollback.ref_version)[1].description == "green"
    @test findcomponentrevision(TestDummyComponentRevision, t2.id, w4PendingRollback.ref_version)[1].description == "pink"
    @test w4PendingRollback.ref_version == t1r3red.ref_invalidfrom
    @test w4PendingRollback.ref_version == t1r4green.ref_validfrom
    @test MaxVersion == t1r4green.ref_invalidfrom
    @test w4PendingRollback.ref_version == t2r1pink.ref_validfrom
end
@testset "rollbacked transaction tests" begin
    rollback_workflow!(w4PendingRollback)
    @test !isempty(findcomponentrevision(TestDummyComponentRevision, t1.id, w4PendingRollback.ref_version))
    w4PendingRollback.ref_version == t1r3red.ref_invalidfrom
    w4PendingRollback.ref_version == t1r4green.ref_validfrom
end
w3redshadow = Workflow(type_of_entity="TestDummyComponent",
    ref_history=w1blue.ref_history,
    tsw_validfrom=ZonedDateTime(2014, 11, 30, 21, 0, 1, 1, tz"UTC"),
)
# 2.3.2 Testing retrospective transactions
# 2.3.2.1 preparing the retrospective transaction by
# preliminarily invalidating all insertions and mutations from shadowed versions and
# reviving all revisions invalidated by shadowed versions
update_entity!(w3redshadow)
@testset "retrospective update entity red revive and invalidate shadowed " begin
    # have currently shadowed revisions been invalidated?
    @test !isempty(find(TestDummyComponentRevision, SQLWhereExpression("ref_invalidfrom=?", w3redshadow.ref_version)))
    # have revisions invalidated by shadowed versions been revived?
    @test !isempty(find(TestDummyComponentRevision, SQLWhereExpression("ref_validfrom=?", w3redshadow.ref_version)))
end
# 2.3.2.2 Does rolling back the transaction delete the preliminary revisions?
rollback_workflow!(w3redshadow)
@testset "retrospective update entity red revive and invalidate shadowed " begin
    # have currently shadowed revisions been invalidated?
    @test isempty(find(TestDummyComponentRevision, SQLWhereExpression("ref_invalidfrom=?", w3redshadow.ref_version)))
    # have revisions invalidated by shadowed versions been revived?
    @test isempty(find(TestDummyComponentRevision, SQLWhereExpression("ref_validfrom=?", w3redshadow.ref_version)))
end

@testset "get_typeof functions" begin
    @test get_typeof_revision(get_typeof_component(TestDummyComponentRevision())()) == TestDummyComponentRevision
end