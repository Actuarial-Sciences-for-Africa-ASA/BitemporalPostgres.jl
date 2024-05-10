[![CI](https://github.com/actuarial-sciences-for-africa-asa/BitemporalPostgres.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/actuarial-sciences-for-africa-asa/BitemporalPostgres.jl/actions/workflows/CI.yml)

[![Documentation](https://github.com/actuarial-sciences-for-africa-asa/BitemporalPostgres.jl/actions/workflows/Documentation.yml/badge.svg)](https://github.com/actuarial-sciences-for-africa-asa/BitemporalPostgres.jl/actions/workflows/Documentation.yml)

[![pages-build-deployment](https://github.com/actuarial-sciences-for-africa-asa/BitemporalPostgres.jl/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/actuarial-sciences-for-africa-asa/BitemporalPostgres.jl/actions/workflows/pages/pages-build-deployment)

[![pkgeval](https://juliahub.com/docs/BitemporalPostgres/pkgeval.svg)](https://juliahub.com/ui/Packages/BitemporalPostgres/ZmypI) Testing on Juliahub fails as PkgEval is not applicable because tests require a running POSTGRES server.

For use cases see [a jupyter notebook with tests ](bitemporal_testcase.ipynb)

# Architecture
BitemporalPostgres provides an API for application based bitemporal, that is: audit proof,  transactions with Julia and Postgres DB. Transactions are "long", with persistent transaction data that is, so they can serve as a basis of workflow management: they can be suspended, resumed and delegated.

A bitemporal data manager creates or mutates bitemporal entities as of a point in reference time.
A bitemporal transaction - here also called workflow - is started in two ways:

create_entity creates
- an instance of history - the root of bitemporal entities -
- a version 
- a validity_interval

update entity creates 
- a version 
- a valididity_interval 
and references  
- a given history

while these data comprise the scaffolding needed for bitemporal tracking of mutations, components and revisions comprise the business payload, as well as subcomponents and their revisions.

thus mutation of Business data consists of 
-creation or invalidation of components/subcomponents together with their revisions and of
- updates of attributes of revisions

# Documentation
[dev]africa-asa.github.io/BitemporalPostgres.jl/dev/)
[stable]africa-asa.github.io/BitemporalPostgres.jl/stable/)

# Usage
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
