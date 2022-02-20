push!(LOAD_PATH,"../src/") 
using Documenter
using BitemporalPostgres, BitemporalPostgres.DDL

makedocs(
    sitename = "BitemporalPostgres",
    format = Documenter.HTML(),
    pages = [
        "Home" => "index.md",
        "BitemporalPostgres API" => [
            "BitemporalPostgres" => "api/BitemporalPostgres.md",
            "DDL" => "api/BitemporalPostgres.DDL.md",
            "Theory" => "api/theory.md",
            "Transactions" => "api/transactions.md"
        ]
    ]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "https://github.com/michaelfliegner/BitemporalPostgres.jl"
)
