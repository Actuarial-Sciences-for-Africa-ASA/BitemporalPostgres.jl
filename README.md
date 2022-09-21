[![CI](https://github.com/actuarial-sciences-for-africa-asa/BitemporalPostgres.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/actuarial-sciences-for-africa-asa/BitemporalPostgres.jl/actions/workflows/CI.yml)

[![Documentation](https://github.com/actuarial-sciences-for-africa-asa/BitemporalPostgres.jl/actions/workflows/Documentation.yml/badge.svg)](https://github.com/actuarial-sciences-for-africa-asa/BitemporalPostgres.jl/actions/workflows/Documentation.yml)

[![pages-build-deployment](https://github.com/actuarial-sciences-for-africa-asa/BitemporalPostgres.jl/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/actuarial-sciences-for-africa-asa/BitemporalPostgres.jl/actions/workflows/pages/pages-build-deployment)

[![pkgeval](https://juliahub.com/docs/BitemporalPostgres/pkgeval.svg)](https://juliahub.com/ui/Packages/BitemporalPostgres/ZmypI) Testing on Juliahub fails as PkgEval is not applicable because tests require a running POSTGRES server.

Release Notes 1.3.2:
Corrected retrospective transactions, see [tests](bitemporal_testcase.ipynb)

# BitemporalPostgres provides an API for application based bitemporal, that is: audit proof,  transactions with Julia and Postgres DB. Transactions are "long", with persistent transaction data that is, so they can serve as a basis of workflow management: they can be suspended, resumed and delegated.

Documentation
[here](https://actuarial-sciences-for-africa-asa.github.io/BitemporalPostgres.jl/dev/)

A web app using this module for persistence is being built at https://github.com/actuarial-sciences-for-africa-asa/BitemporalReactive.jl


## This project is a [Julia](https://julialang.org/) template configured for ephemeral development environments on [Gitpod](https://www.gitpod.io/). 
If You start this repo in [gitpod](https://www.gitpod.io/docs/), You can open [this jupyter notebook](./bitemporal_testcase.ipynb) in vscode and execute the included code snippets with julia and postgres up and running.

## Next Steps

Click the button below to start a new development environment:

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/gitpod-io/template-julia)

## Get Started With Your Own Project

### A new project

Click the above "Open in Gitpod" button to start a new workspace. Once you're ready to push your first code changes, Gitpod will guide you to fork this project 
so you own it.
