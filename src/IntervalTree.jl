module IntervalTree
using AbstractTrees
import AbstractTrees: children, printnode
import BitemporalPostgres
using BitemporalPostgres
using TimeZones
import SearchLight
using SearchLight
export Node, n0, n2, print_tree, mkforest

struct Node
    interval::ValidityInterval
    shadowed::Vector{Node}
end

function children(n::Node)
    return n.shadowed
end

printnode(io::IO, n::Node) = print(io, n.interval.ref_history.value * n.interval.ref_version.value )

n0 = Node(ValidityInterval(), Node[])
n2 = Node(ValidityInterval(), [Node(ValidityInterval(), []), Node(ValidityInterval(), [])])
print_tree(n2)

function mkforest(
    hid::DbId,
    tsdb_invalidfrom::ZonedDateTime,
    tsworld_validfrom::ZonedDateTime,
    tsworld_invalidfrom::ZonedDateTime,
)::Vector{Node}
    forest = find(
        ValidityInterval,
        SQLWhereExpression(
            "ref_history=? AND  upper(tsrdb)=? AND tstzrange(?,?) * tsrworld = tsrworld",
            hid,
            tsdb_invalidfrom,
            tsworld_validfrom,
            tsworld_invalidfrom,
        ),
    )
    shadowed::Vector{Node} = map(
        i::ValidityInterval -> Node(
            i,
            mkforest(hid, i.tsdb_validfrom, i.tsworld_validfrom, i.tsworld_invalidfrom),
        ),
        forest,
    )
    return shadowed
end

SearchLight.Configuration.load() |> SearchLight.connect
mkforest(DbId(1), MaxDate, ZonedDateTime(1900, 1, 1, 0, 0, 0, 0, tz"UTC"), MaxDate)
end