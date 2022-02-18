push!(LOAD_PATH,"../src/") 
using Documenter
using BitemporalPostgres

makedocs(
    sitename = "BitemporalPostgres",
    format = Documenter.HTML(),
    pages = [
        "Home" => "index.md",
        "BitemporalPostgres API" => [
            "BitemporalPostgres" => "api/BitemporalPostgres.md",
            "Theory" => "api/theory.md"
        ]
    ]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "https://github.com/Kaeptenblaubaer/BitemporalPostgres"
)
