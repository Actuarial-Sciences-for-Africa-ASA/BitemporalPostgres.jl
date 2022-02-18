module BitemporalPostgres
import SearchLight: AbstractModel, DbId, query, save!
import SearchLightPostgreSQL
import Base: @kwdef
import Intervals, Dates, TimeZones
using Intervals,
    Dates, SearchLight, SearchLight.Transactions, SearchLightPostgreSQL, TimeZones
export History,
    Version,
    Component,
    get_typeof_revision,
    SubComponent,
    ComponentRevision,
    ValidityInterval,
    TestDummyComponent,
    TestDummyComponentRevision,
    TestDummySubComponent,
    TestDummySubComponentRevision,
    Testtstzrange,
    Workflow,
    findversion,
    findcomponentrevision,
    create_entity!,
    create_component!,
    create_subcomponent!,
    update_entity!,
    update_component!,
    delete_component!,
    commit_workflow!,
    maxVersion,
    maxDate,
    infinityKey

"""
  Workflow
  Holds application based transaction data.
  * current version
  * world validFrom date
  * db validfrom date

"""
@kwdef mutable struct Workflow <: AbstractModel
    id::DbId = DbId()
    ref_history::DbId = 0
    ref_version::DbId = 0
    tsdb_validfrom::ZonedDateTime = maxDate
    tsw_validfrom::ZonedDateTime = maxDate
    is_committed::Integer = 0
end

@kwdef mutable struct Testtstzrange <: AbstractModel
    id::DbId = DbId()
    i::Interval{ZonedDateTime,Closed,Open} = Interval{ZonedDateTime,Closed,Open}(
        ZonedDateTime(2013, 2, 13, 0, 30,0,1, tz"America/Winnipeg"),
        ZonedDateTime(2030, 2, 13, 0, 30,0,1, tz"America/Winnipeg")
    )
end

"""
  History

  The root of an aggregate entity, which groups versions and entities

"""
@kwdef mutable struct History <: AbstractModel
    id::DbId = DbId()
    dummy::Integer = 0
end
# One ms less than the maximum date, as 
maxDate = ZonedDateTime(DateTime(2038, 1, 19, 3, 14, 6, 999), tz"UTC")
maxDateSQL = SQLInput(maxDate)
infinityKey = 9223372036854775807::Integer
"""
  Version

  version number of the state of aggregate entity 

"""
@kwdef mutable struct Version <: AbstractModel
    id::DbId = DbId()
    ref_history::DbId = infinityKey
end

"""
ValidityInterval

  a 2-dimensional interval of validity of a version
  with respect to the state
  
  * of the data base storage and 
  * of the world 

"""
@kwdef mutable struct ValidityInterval <: AbstractModel
    id::DbId = DbId()
    ref_history::DbId = infinityKey
    ref_version::DbId = infinityKey
    tsrworld::Interval{ZonedDateTime,Closed,Open}=Interval{ZonedDateTime,Closed,Open}(now(tz"UTC"),maxDate)
    tsrdb::Interval{ZonedDateTime,Closed,Open}=Interval{ZonedDateTime,Closed,Open}(now(tz"UTC"),maxDate)
    is_committed::Integer = 0
end

"""
Component

  an abstract component of a bitemporal entity
  i.e. a contract, a reference to a partner
  a component's history of states is represented by its revisions 

"""
abstract type Component <: AbstractModel end

function getid(component::Component)::DbId
    component.id
end

function getref_history(component::Component)::DbId
    component.ref_history
end

function setref_history(component::Component, ref::DbId)
    component.ref_history = ref
end

"""
SubComponent

  an abstract subcomponent of a bitemporal entity
  i.e. product item of a contract

"""
abstract type SubComponent <: Component end

function getref_super(component::Component)::DbId
    component.ref_super
end

function setref_super(subcomponent::SubComponent, ref::DbId)
    subcomponent.ref_super = ref
end

"""
ComponentRevision

  a component of a bitemporal entity
  i.e. a contract, a reference to a partner
  a component's history of states is represented by its revisions 

"""
abstract type ComponentRevision <: AbstractModel end

"""
get_typeof_revision(component::T) :: R where {T<: Component, R <: ComponentRevision} 
    returns the actual subtype of ComponentRevision that fits the actual type of component 
"""
function get_typeof_revision(component::T) :: Type{R} where {T<: Component, R <: ComponentRevision} 
    Type{R}
end

function getid(rev::ComponentRevision)::DbId
    rev.id
end

function getref_component(rev::ComponentRevision)::DbId
    rev.ref_component
end

function setref_component(rev::ComponentRevision, ref::DbId)
    rev.ref_component = ref
end

function getref_validfrom(ref::DbId)::ComponentRevision
    rev.ref_validfrom = ref
end

function setref_validfrom(rev::ComponentRevision, ref::DbId)
    rev.ref_validfrom = ref
end

function getref_invalidfrom(ref::DbId)::ComponentRevision
    rev.ref_invalidfrom = ref
end

function setref_invalidfrom(rev::ComponentRevision, ref::DbId)
    rev.ref_invalidfrom = ref
end

"""
TestDummyComponent <: Component

  a component of a bitemporal entity

"""
@kwdef mutable struct TestDummyComponent <: Component
    id::DbId = DbId()
    ref_history::DbId = infinityKey
end

"""
get_typeof_revision(component::TestDummyComponent) :: T where {T<:ComponentRevision}
"""
function get_typeof_revision(component::TestDummyComponent) :: T where {T<:ComponentRevision}
    TestDummyComponentRevision
end

"""
TestDummyComponentRevision <: ComponentRevision

  a revision of a contract component of a bitemporal entity

"""
@kwdef mutable struct TestDummyComponentRevision <: ComponentRevision
    id::DbId = DbId()
    ref_component::DbId = infinityKey
    ref_validfrom::DbId = infinityKey
    ref_invalidfrom::DbId = infinityKey
    description::String = ""
end

Base.copy(src::TestDummyComponentRevision) = TestDummyComponentRevision(
    ref_component = src.ref_component,
    description = src.description,
)

"""
TestDummySubComponent <: Component
  a component of a bitemporal entity

"""
@kwdef mutable struct TestDummySubComponent <: SubComponent
    id::DbId = DbId()
    ref_history::DbId = infinityKey
    ref_super::DbId = infinityKey
end

"""
get_typeof_revision(component::TestDummySubComponent) :: T where {T<:ComponentRevision}
"""
function get_typeof_revision(component::TestDummySubComponent) :: Type{TestDummySubComponentRevision}
    TestDummySubComponentRevision
end

"""
TestDummySubComponentRevision <: ComponentRevision

  a revision of a contract component of a bitemporal entity

"""
@kwdef mutable struct TestDummySubComponentRevision <: ComponentRevision
    id::DbId = DbId()
    ref_component::DbId = infinityKey
    ref_validfrom::DbId = infinityKey
    ref_invalidfrom::DbId = infinityKey
    description::String = ""
end

Base.copy(src::TestDummySubComponentRevision) = TestDummySubComponentRevision(
    ref_component = src.ref_component,
    description = src.description,
)
"""
findversion(ref_history::DbId, tsdb::ZonedDateTime, tsw::ZonedDateTime)::DbId
       retrieves the version_id of a bitemporal history asof tsdb as per tsw
"""
function findversion(ref_history::DbId, tsdb::ZonedDateTime, tsw::ZonedDateTime)::DbId
    find(
        ValidityInterval,
        SQLWhereExpression(
            "ref_history=? and tsrworld @> TIMESTAMPTZ ? AND tsrdb @> TIMESTAMPTZ ?",
            ref_history,
            SQLInput(tsw),
            SQLInput(tsdb),
        ),
    )[1].ref_version
end

"""
findcomponentrevision(t::Type{T},ref_component::DbId,ref_version::DbId,)::Vector{T} where {T<:ComponentRevision}
    retrieves the version_id of a bitemporal history asof tsdb as per tsw
"""
function findcomponentrevision(t::Type{T},ref_component::DbId,ref_version::DbId,)::Vector{T} where {T<:ComponentRevision}
    find(
        t,
        SQLWhereExpression(
            "ref_component = ? AND ref_valid @> BIGINT ? ",
            ref_component,
            ref_version,
        ),
    )
end

"""
create_entity!(w::Workflow)

persists a history, version, validityInterval and a Workflow 
requires: w.tsw_validfrom is a valid date

"""
function create_entity!(w::Workflow)
    transaction() do
        h = History()
        save!(h)
        v = Version(ref_history = h.id)

        save!(v)

        w.ref_history = h.id
        w.ref_version = v.id
        save!(w)

        i = ValidityInterval(
            ref_history = h.id,
            ref_version = v.id,
            tsrworld = Interval{ZonedDateTime,Closed,Open}(w.tsw_validfrom,maxDate),
            tsrdb = Interval{ZonedDateTime,Closed,Open}(now(tz"Africa/Porto-Novo"),maxDate)
        )
        save!(i)
    end
end

"""
create_component!(c::Component, cr :: ComponentRevision, w:: Workflow) 

creates a component and a componentRevision

"""
function create_component!(c::Component, cr::ComponentRevision, w::Workflow)
    transaction() do
        hid = w.ref_history
        vid = w.ref_version
        setref_history(c, hid)
        save!(c)

        setref_component(cr, getid(c))
        setref_validfrom(cr, vid)
        save!(cr)
    end
end

"""
create_subcomponent!(c::Component, sc::SubComponent, cr :: ComponentRevision, w:: Workflow) 
creates a subcomponent and a componentRevision
"""
function create_subcomponent!(
    c::Component,
    sc::SubComponent,
    cr::ComponentRevision,
    w::Workflow,
)
    transaction() do
        hid = w.ref_history
        vid = w.ref_version
        setref_super(sc, c.id)
        setref_history(sc, hid)
        save!(sc)

        setref_component(cr, getid(sc))
        setref_validfrom(cr, vid)
        save!(cr)
    end
end

"""
update_entity!(w::Workflow)

persists a version, a validityInterval and a Workflow 
requires: w.tsw_validfrom is a valid date
          w.ref_history is a valid history id
          w.ref_version is a valid version of w.ref_history

"""
function update_entity!(w::Workflow)
    transaction() do
        hid = w.ref_history
        v = Version(ref_history = hid)
        save!(v)
        w.ref_version = v.id
        save!(w)

        i = ValidityInterval(
            ref_history = hid,
            ref_version = v.id,
            tsrworld = Interval{ZonedDateTime,Closed,Open}(w.tsw_validfrom,maxDate),
            tsrdb = Interval{ZonedDateTime,Closed,Open}(now(tz"Africa/Porto-Novo"),maxDate)
        )
        save!(i)
    end
end


"""
update_component!(cr :: ComponentRevision, crNew :: ComponentRevision, w:: Workflow) 

terminates a componentRevision and persists its successor

"""
function update_component!(cr::ComponentRevision, crNew::ComponentRevision, w::Workflow)
    transaction() do
        vid = w.ref_version
        setref_invalidfrom(cr, vid)
        save!(cr)

        setref_validfrom(crNew, vid)
        save!(crNew)
    end
end

"""
delete_component!(c::T, w::Workflow)  where {T<:Component}

 * deletes a component if it was created for the current version or
 * mark its latest component revision as invalid

"""
function delete_component!(c::T, w::Workflow)  where {T<:Component}
    transaction() do
        vid = w.ref_version
        revs=find(get_typeof_revision(c),SQLWhereExpression("ref_component=?",c.id))
        if length(revs)==1 && revs[1].ref_validfrom == vid
            """
            c was created for current version, foreign key constraint cascades  deletion to revision 
            """
            delete(c)
        else
            for r in revs 
                if vid.value >= r.ref_validfrom.value && vid.value < r.ref_invalidfrom.value
                    """
                    the current revision gets terminated 
                    """
                    r.ref_invalidfrom = vid
                    save!(r)
                end
            end
        end
    end
end

"""
commit_workflow!(w::Workflow)
  commits the application based transaction 
  begun with the creation of w
  * sets w's version's validityInterval to is_committed
  * ends all overlapping intervals to tsdb_invalidfrom w.tsdb_validfrom
  * creates a new interval for the non_overlapping part of a partially interval if any
"""
function commit_workflow!(w::Workflow)
    transaction() do
        w.tsdb_validfrom = now(tz"Africa/Porto-Novo")

        uncommitted = find(
            ValidityInterval,
            SQLWhereExpression("ref_version = ?  AND is_committed = 0", w.ref_version),
        )

        shadowed = find(
            ValidityInterval,
            SQLWhereExpression(
                "ref_history = ?  AND tsrdb @> TIMESTAMPTZ ? AND tsrworld <@ tstzrange(?,?) AND is_committed=1",
                w.ref_history,
                maxDate - Dates.Day(1),
                uncommitted[1].tsrworld.first + Dates.Day(1),
                uncommitted[1].tsrworld.last,
            ),
        )

        for i in shadowed
            i.tsrdb = Interval{ZonedDateTime,Closed,Open}(i.tsrdb.first,w.tsdb_validfrom)
            save!(i)
        end

        overlapped = find(
            ValidityInterval,
            SQLWhereExpression(
                "ref_history = ?  AND tsrdb @> TIMESTAMPTZ ? AND tsrworld && tstzrange(?,?) AND is_committed=1",
                w.ref_history,
                maxDate - Dates.Day(1),
                uncommitted[1].tsrworld.first + Dates.Day(1),
                uncommitted[1].tsrworld.last,
            ),
        )
        for i in overlapped
            i.tsrdb = Interval{ZonedDateTime,Closed,Open}(i.tsrdb.first,w.tsdb_validfrom)
            j = ValidityInterval(
                ref_history = i.ref_history,
                ref_version = i.ref_version,
                tsrdb = Interval{ZonedDateTime,Closed,Open}(w.tsdb_validfrom,maxDate),
                tsrworld = Interval{ZonedDateTime,Closed,Open}(i.tsrworld.first,uncommitted[1].tsrworld.first),
                is_committed = 1
            )
            save!(i)
            save!(j)
        end
        for i in uncommitted
            i.is_committed = 1
            save!(i)
        end
        w.is_committed = 1
        save!(w)
    end
end
end # module
