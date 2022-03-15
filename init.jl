using Pkg
Pkg.activate(".")
Pkg.instantiate()
Pkg.update()
Pkg.add("SearchLight")
Pkg.add("SearchLightPostgreSQL")
Pkg.add("Intervals")
Pkg.add("TimeZones")
Pkg.add("Dates")
Pkg.add("ToStruct")
import BitemporalPostgres
