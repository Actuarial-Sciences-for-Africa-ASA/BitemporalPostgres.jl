using Pkg
Pkg.activate(".")
Pkg.instantiate()
Pkg.update()
Pkg.add(url="https://github.com/GenieFramework/SearchLight.jl")
Pkg.add("SearchLightPostgreSQL")
Pkg.add("Intervals")
Pkg.add("TimeZones")
Pkg.add("Dates")
Pkg.add("ToStruct")
Pkg.add("Documenter")
import BitemporalPostgres
