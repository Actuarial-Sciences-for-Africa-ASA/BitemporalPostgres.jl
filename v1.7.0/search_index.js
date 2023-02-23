var documenterSearchIndex = {"docs":
[{"location":"api/BitemporalPostgres.DDL/#BitemporalPostgres.DDL.jl","page":"DDL","title":"BitemporalPostgres.DDL.jl","text":"","category":"section"},{"location":"api/BitemporalPostgres.DDL/","page":"DDL","title":"DDL","text":"Modules = [BitemporalPostgres.DDL]","category":"page"},{"location":"api/BitemporalPostgres.DDL/#BitemporalPostgres.DDL.create_validity_intervals_constraints-Tuple{}","page":"DDL","title":"BitemporalPostgres.DDL.create_validity_intervals_constraints","text":"createvalidityintervals_constraints()   Install the GIST constraint that prevents creation of overlapping intervals, i.e.   that at most one version is valid for a given 2 dimensional point in transaction and reference time\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres.DDL/#BitemporalPostgres.DDL.create_versions_trigger-Tuple{}","page":"DDL","title":"BitemporalPostgres.DDL.create_versions_trigger","text":"createversionstrigger()   propagate skalars refvalidfrom and refinvalidfrom to range ref_valid   skalars are needed enable foreign key constraints, which in POSTGRES cannot be declared   onto bounds of intervals directly.\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres.DDL/#BitemporalPostgres.DDL.down-Tuple{}","page":"DDL","title":"BitemporalPostgres.DDL.down","text":"down() callback from SearchLight.Migrations.down  tearing down the Database Schema for bitemproal Transactions including test dummy tables\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres.DDL/#BitemporalPostgres.DDL.up-Tuple{}","page":"DDL","title":"BitemporalPostgres.DDL.up","text":"up() callback from SearchLight.Migrations.up  creating the Database Schema for bitemporal Transactions including test dummy tables\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.jl","page":"BitemporalPostgres","title":"BitemporalPostgres.jl","text":"","category":"section"},{"location":"api/BitemporalPostgres/","page":"BitemporalPostgres","title":"BitemporalPostgres","text":"Modules = [BitemporalPostgres]","category":"page"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.InfinityKey","page":"BitemporalPostgres","title":"BitemporalPostgres.InfinityKey","text":"InfinityKey      in order to ease integration with javascript we use javascript's MAXSAFEINTEGER 2^53 - 1\n\n\n\n\n\n","category":"constant"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.Component","page":"BitemporalPostgres","title":"BitemporalPostgres.Component","text":"Component\n\nan abstract component of a bitemporal entity   i.e. a contract, a reference to a partner   a component's history of states is represented by its revisions \n\n\n\n\n\n","category":"type"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.ComponentRevision","page":"BitemporalPostgres","title":"BitemporalPostgres.ComponentRevision","text":"ComponentRevision\n\na component of a bitemporal entity   i.e. a contract, a reference to a partner   a component's history of states is represented by its revisions \n\n\n\n\n\n","category":"type"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.History","page":"BitemporalPostgres","title":"BitemporalPostgres.History","text":"History\n\nThe root of an aggregate entity, which groups versions and entities\n\n\n\n\n\n","category":"type"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.NoVersionFound","page":"BitemporalPostgres","title":"BitemporalPostgres.NoVersionFound","text":"NoVersionFound     showing component type, id and version id\n\n\n\n\n\n","category":"type"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.Node","page":"BitemporalPostgres","title":"BitemporalPostgres.Node","text":"Node\n\nnode of tree of mutations \n\n\n\n\n\n","category":"type"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.Role","page":"BitemporalPostgres","title":"BitemporalPostgres.Role","text":"Role\n\nrole of a relationship \n\n\n\n\n\n","category":"type"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.SubComponent","page":"BitemporalPostgres","title":"BitemporalPostgres.SubComponent","text":"SubComponent\n\nan abstract subcomponent of a bitemporal entity   i.e. product item of a contract\n\n\n\n\n\n","category":"type"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.TestDummyComponent","page":"BitemporalPostgres","title":"BitemporalPostgres.TestDummyComponent","text":"TestDummyComponent <: Component\n\na component of a bitemporal entity\n\n\n\n\n\n","category":"type"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.TestDummyComponentRevision","page":"BitemporalPostgres","title":"BitemporalPostgres.TestDummyComponentRevision","text":"TestDummyComponentRevision <: ComponentRevision\n\na revision of a contract component of a bitemporal entity\n\n\n\n\n\n","category":"type"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.TestDummySubComponent","page":"BitemporalPostgres","title":"BitemporalPostgres.TestDummySubComponent","text":"TestDummySubComponent <: Component   a component of a bitemporal entity\n\n\n\n\n\n","category":"type"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.TestDummySubComponentRevision","page":"BitemporalPostgres","title":"BitemporalPostgres.TestDummySubComponentRevision","text":"TestDummySubComponentRevision <: ComponentRevision\n\na revision of a contract component of a bitemporal entity\n\n\n\n\n\n","category":"type"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.TooManyVersionsFound","page":"BitemporalPostgres","title":"BitemporalPostgres.TooManyVersionsFound","text":"TooManyVersionsFound     showing component type, id and version id     indicates an error in committing of versions\n\n\n\n\n\n","category":"type"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.ValidityInterval","page":"BitemporalPostgres","title":"BitemporalPostgres.ValidityInterval","text":"ValidityInterval\n\na 2-dimensional interval of validity of a version   with respect to the state\n\nof the data base storage and \nof the world \n\nSee the theory page for background\n\n\n\n\n\n","category":"type"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.Version","page":"BitemporalPostgres","title":"BitemporalPostgres.Version","text":"Version\n\nversion number of the state of aggregate entity \n\n\n\n\n\n","category":"type"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.VersionException","page":"BitemporalPostgres","title":"BitemporalPostgres.VersionException","text":"VersionException\n\nthrown on versioning errors\n\n\n\n\n\n","category":"type"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.Workflow","page":"BitemporalPostgres","title":"BitemporalPostgres.Workflow","text":"Workflow   Holds application based transaction data.\n\ncurrent version\nworld validFrom date\ndb validfrom date\nis_committed means: bitemporal transaction is\npending: 0\ncommitted: 1\nrolled back: 2\n\n\n\n\n\n","category":"type"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.commit_workflow!-Tuple{BitemporalPostgres.Workflow}","page":"BitemporalPostgres","title":"BitemporalPostgres.commit_workflow!","text":"commitworkflow!(w::Workflow)   commits the bitemporal transaction identified by refversion   begun with the creation of w\n\nsets w's version's validityInterval to is_committed\nends all overlapping intervals to tsdbinvalidfrom w.tsdbvalidfrom\ncreates a new interval for the non_overlapping part of a partially interval if any\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.create_component!-Tuple{BitemporalPostgres.Component, BitemporalPostgres.ComponentRevision, BitemporalPostgres.Workflow}","page":"BitemporalPostgres","title":"BitemporalPostgres.create_component!","text":"create_component!(c::Component, cr :: ComponentRevision, w:: Workflow) \n\ncreates a component and a componentRevision\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.create_entity!-Tuple{BitemporalPostgres.Workflow}","page":"BitemporalPostgres","title":"BitemporalPostgres.create_entity!","text":"create_entity!(w::Workflow)\n\nopens a bitemporal transaction identified by ref_version\npersists a history, version, validityInterval and a Workflow \nrequires: w.tsw_validfrom is a valid date\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.create_subcomponent!-Tuple{BitemporalPostgres.Component, BitemporalPostgres.SubComponent, BitemporalPostgres.ComponentRevision, BitemporalPostgres.Workflow}","page":"BitemporalPostgres","title":"BitemporalPostgres.create_subcomponent!","text":"create_subcomponent!(c::Component, sc::SubComponent, cr :: ComponentRevision, w:: Workflow)  creates a subcomponent and a componentRevision\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.delete_component!-Union{Tuple{T}, Tuple{T, BitemporalPostgres.Workflow}} where T<:BitemporalPostgres.Component","page":"BitemporalPostgres","title":"BitemporalPostgres.delete_component!","text":"delete_component!(c::T, w::Workflow)  where {T<:Component}\n\ndeletes a component if it was created for the current version or\nmark its latest component revision as invalid\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.delete_component!-Union{Tuple{T}, Tuple{T, BitemporalPostgres.Workflow}} where T<:BitemporalPostgres.ComponentRevision","page":"BitemporalPostgres","title":"BitemporalPostgres.delete_component!","text":"delete_component!(r::T, w::Workflow)  where {T<:ComponentRevision}\n\ndeletes a component if it was created for the current version or\nmark its latest component revision as invalid\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.findcomponentrevision-Union{Tuple{T}, Tuple{Type{T}, SearchLight.DbId, SearchLight.DbId}} where T<:BitemporalPostgres.ComponentRevision","page":"BitemporalPostgres","title":"BitemporalPostgres.findcomponentrevision","text":"findcomponentrevision(t::Type{T},refcomponent::DbId,refversion::DbId,)::Vector{T} where {T<:ComponentRevision}     retrieves the version_id of a bitemporal history asof tsdb as per tsw\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.findversion","page":"BitemporalPostgres","title":"BitemporalPostgres.findversion","text":"findversion(refhistory::DbId, tsdb::ZonedDateTime, tsw::ZonedDateTime, committed::Integer=1)::DbId        retrieves the versionid of a bitemporal history asof tsdb as per tsw\n\n\n\n\n\n","category":"function"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.get_revision-Union{Tuple{RT}, Tuple{CT}, Tuple{Type{CT}, Type{RT}, SearchLight.DbId, SearchLight.DbId}} where {CT<:BitemporalPostgres.Component, RT<:BitemporalPostgres.ComponentRevision}","page":"BitemporalPostgres","title":"BitemporalPostgres.get_revision","text":"get_revision(ctype::Type{CT}, rtype::Type{RT}, hid::DbId, vid::DbId) where {CT<:Component,RT<:ComponentRevision}\n\nretrieves the revision of the unique component of type CT in history hid as of version vid \nthe revision must exist\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.get_revision-Union{Tuple{RT}, Tuple{Type{RT}, SearchLight.DbId, SearchLight.DbId}} where RT<:BitemporalPostgres.ComponentRevision","page":"BitemporalPostgres","title":"BitemporalPostgres.get_revision","text":"get_revision(rtype::Type{RT}, cid::DbId, vid::DbId) where {RT<:ComponentRevision}\n\nretrieves the revision of component cid as of version vid \nthe revision must exist\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.get_revisionIfAny-Union{Tuple{RT}, Tuple{CT}, Tuple{Type{CT}, Type{RT}, SearchLight.DbId, SearchLight.DbId}} where {CT<:BitemporalPostgres.Component, RT<:BitemporalPostgres.ComponentRevision}","page":"BitemporalPostgres","title":"BitemporalPostgres.get_revisionIfAny","text":"function get_revisionIfAny( ctype::Type{CT}, rtype::Type{RT}, hid::DbId, vid::DbId, )::Vector{RT} where {CT<:Component,RT<:ComponentRevision}     retrieves the revision of the unique component of type CT in history hid if one exists as of version vid \n\nAn optional (unique) component may have a revision for a version later as vid. In such cases a component w/o valid revision is itself valid, just to be ignored for the current version.\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.get_revisionIfAny-Union{Tuple{RT}, Tuple{Type{RT}, SearchLight.DbId, SearchLight.DbId}} where RT<:BitemporalPostgres.ComponentRevision","page":"BitemporalPostgres","title":"BitemporalPostgres.get_revisionIfAny","text":"function get_revisionIfAny(rtype::Type{RT}, hid::DbId, vid::DbId, )::Vector{RT} where {RT<:ComponentRevision}     retrieves the revision of component cid if one exists as of version vid \n\nAn optional component may have a revision for a version later as vid. In such cases a component w/o valid revision is itself valid, just to be ignored for the current version.\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.get_typeof_component-Tuple{BitemporalPostgres.TestDummyComponentRevision}","page":"BitemporalPostgres","title":"BitemporalPostgres.get_typeof_component","text":"gettypeofcomponent(revision::TestDummyComponentRevision) :: Type{TestDummyComponent}\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.get_typeof_component-Union{Tuple{R}, Tuple{T}} where {T<:BitemporalPostgres.ComponentRevision, R<:BitemporalPostgres.Component}","page":"BitemporalPostgres","title":"BitemporalPostgres.get_typeof_component","text":"gettypeofcomponent(component::T)::Type{R} where {T<:ComponentRevision,R<:Component}     returns the actual subtype of Component that fits the actual type of ComponentRevision \n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.get_typeof_revision-Tuple{BitemporalPostgres.TestDummyComponent}","page":"BitemporalPostgres","title":"BitemporalPostgres.get_typeof_revision","text":"gettypeofrevision(component::TestDummyComponent) :: Type{TestDummyComponentRevision}\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.get_typeof_revision-Union{Tuple{R}, Tuple{T}} where {T<:BitemporalPostgres.Component, R<:BitemporalPostgres.ComponentRevision}","page":"BitemporalPostgres","title":"BitemporalPostgres.get_typeof_revision","text":"gettypeofrevision(component::T)::Type{R} where {T<:Component,R<:ComponentRevision}     returns the actual subtype of ComponentRevision that fits the actual type of Component \n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.mkforest-Tuple{SearchLight.DbId}","page":"BitemporalPostgres","title":"BitemporalPostgres.mkforest","text":"mkforest(hid::DbId)::Vector{Node}\n\nbuilds a forest of version nodes where\n* eventual child node vectors denote mutations which have been retrospectively corrected by their predecessor\n\n\nsee: Theory: Textual representation of mutation histories\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.mktree-Tuple{Integer, Dict{Integer, Integer}, Dict{Integer, Vector{Integer}}}","page":"BitemporalPostgres","title":"BitemporalPostgres.mktree","text":"function mktree(version::Integer, vidsDict::Dict{Integer,Integer}, treeDict::Dict{Integer,Vector{Integer}})::BitemporalPostgres.Node\n\nbuilds a tree of versipon nodes with child node vectors denoting\nmutations which have been retrospectively corrected by their parent = predecessor\n\nsee: Theory: Textual representation of mutation histories\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.revisionTypes-Tuple{Val{:TestDummyComponent}}","page":"BitemporalPostgres","title":"BitemporalPostgres.revisionTypes","text":"revisionTypes(entity::Val{:TestDummyComponent})    defining the ComponentRevision types occurring in TestDummyComponents\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.revisionTypes-Union{Tuple{Val{T}}, Tuple{T}} where T<:Symbol","page":"BitemporalPostgres","title":"BitemporalPostgres.revisionTypes","text":"revisionTypes(entity::Val{T})::Vector{T} where {T<:Symbol}     list of subtypes of ComponentRevision that are subcomponents     of \n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.rollback_workflow!-Tuple{BitemporalPostgres.Workflow}","page":"BitemporalPostgres","title":"BitemporalPostgres.rollback_workflow!","text":"rollbackworkflow!(w::Workflow)     rolls back the bitemporal transaction identified by refversion     begun with the creation of w\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.update_component!-Tuple{BitemporalPostgres.ComponentRevision, BitemporalPostgres.ComponentRevision, BitemporalPostgres.Workflow}","page":"BitemporalPostgres","title":"BitemporalPostgres.update_component!","text":"update_component!(cr :: ComponentRevision, crNew :: ComponentRevision, w:: Workflow) \n\nterminates a componentRevision and persists its successor\n\n\n\n\n\n","category":"method"},{"location":"api/BitemporalPostgres/#BitemporalPostgres.update_entity!-Tuple{BitemporalPostgres.Workflow}","page":"BitemporalPostgres","title":"BitemporalPostgres.update_entity!","text":"update_entity!(w::Workflow)\n\nopens a bitemporal transaction identified by ref_version\npersists a version, a validityInterval and a Workflow \nFor retrospective transactions\npreliminarily invalidates all insertions and mutations from shadowed versions\npreliminarily revives all revisions invalidated by shadowed versions\nrequires:\nw.tsw_validfrom is a valid date\nw.ref_history is a valid history id\nw.refversion is a valid version of w.refhistory\n\n\n\n\n\n","category":"method"},{"location":"api/theory/#A-Julia-template-for-Bitemporal-Data-Management-based-on-SearchLight.jl","page":"Theory","title":"A Julia template for Bitemporal Data Management based on SearchLight.jl","text":"","category":"section"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"This package provides generic functions for CRUD of bitemporal aggregate entities. Serializing and deserializing is provided by packages JSON and ToStruct.","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"The package's application based transaction logic comprises reified transactions such that even pending transactions' data are persistent. Pending transactions can therefore be suspended, resumed and delegated: passed between users within workflows.","category":"page"},{"location":"api/theory/#Twodimensional-intervals-representing-panes-of-validity","page":"Theory","title":"Twodimensional intervals representing panes of validity","text":"","category":"section"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"Bitemporal data management models temporal references of data, such as","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"a contract's begin of validity,i.e. from when on it shall be executed\na contract's date of signature, or in a computational context: the timestamp of its final (committed) insertion into a database.","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"For instance, we agreed","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"on Monday on s.th. we call the blue agreement beginning next year,\non Tuesday on the yellow one beginning two years later, and\non Wednesday on the red one instead, beginning already one year later\nand leave it at that.","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"Our model is to provide answers to questions like","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"\"What did we think at transaction time what we agreed upon as of referenced time\"","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"Reference time and transaction time can be seen as constituting a point which is contained in a rectangle of validity and thus identifies a version.","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"The first idea of this approach is spatial representation of the two temporal dimensions. The above course of agreements would be described by sets of adjacent rectangles, reference time running horizontally, transaction time vertically and versions eperesented by colour.","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"(Image: Areas of Validity)","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"Let's denote these rectangles by 2dimensional intervals, where lower stands for the start time, which is included, and upper for the end time which is not included. upper = infinity stands for an unspecified end time. We shall use use v to denote the version, i.e. the state of the object's attribute values that persists in the interval of validity.","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"While under this interpretation","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"the first dimension allows references to past or future points in time just as human language does,\nthe second dimension allows\nonly references to the past for lower as for the assertion to even exist in the data base it must have been entered at some past point of time; and\nreferences to the past and to infinity for upper as the time of its revocation can be past as well as yet unspecified.","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"d_lower d_upper) w_lowerw_upper)","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"The first, blue, part in the above example is open ended in both dimensions, no end of world validity is intended and no mutation of the data base has been done yet,","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"(v_blued_lower )w_lower) )","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"The second part, the transition to yellow can be denoted like so:","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"beginaligned\ntextlet \ns_0 =  (v_blued_0 )w_0 ) )  \nt_1 = (d_1w_1)  \ntextwhere  d_1  d_0 w_1  w_0 \ntextthen mutation of  s_0 text to yellow per   t_1 text equals \n ( v_blue d_0 d_1) w_0) d_1) w_0w_1) )\n ( v_yellow d_1) w_1 ) )\nendaligned","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"The third part, the mutation overwriting yellow with red, can be denoted like so:","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"beginaligned\ntextlet \ns_1 =  ( v_blue d_0 d_1) w_0) d_1) w_0w_1) ) ( v_yellow d_1) w_1 ) )\nt_2 = (d_2w_2)\ntextwhere  d_2  d_1 w_2  w_1 \ntextthen mutation of  s_1 text to red per   t_1 text equals \nendaligned \nbeginaligned\n ( v_blue d_0d_1) w_0) d_1d_2) w_0w_1) d_2) w_0w_2) )\n   ( v_yellow d_1d_2) w_1) )\n    ( v_red d_2) w_2) ) \nendaligned","category":"page"},{"location":"api/theory/#Representing-bitemporal-aggregations","page":"Theory","title":"Representing bitemporal aggregations","text":"","category":"section"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"When we look at bitemporal aggregates we find components that can change independently at different times, like for instance an insurance contract with subobjects like a reference to the premium payer, tariff parameters like height of premium, modes of payment, date of last payment etc.etc.. Thus we find that these subobjects need their own intervals of validity; but because the aggregate changes whenever a component changes, the aggregate version can share its intervals with the changing components. Let's enhance our example such that we have three components of which","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"one is added at creation as of the blue version of the aggregate, but deleted as of the yellow one\nanother added at creation as of the yellow version of the aggregate, but deleted as of the red one and\na third, is added at creation as of the blue version of the aggregate, and kept as of the yellow and red versions","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"beginaligned\nh = ( v_blue d_0d_1) w_0) d_1d_2) w_0w_1) d_2) w_0w_2) )\n      ( v_yellow d_1d_2) w_1) )\n      ( v_red d_2) w_2) ) \n\nc_i = ( v_blue d_0d_1) w_0) d_1d_2) w_0w_1) d_2) w_0w_2) )\nc_2 = ( v_yellow d_1d_2) w_1) )\nc_3 = ( v_blue d_0d_1) w_0) d_1d_2) w_0w_1) d_2) w_0w_2) )( v_yellow d_1d_2) w_1)(v_red d_2) w_2) )\nendaligned","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"This can be simplified by substituting the interval sets by references to the versions they are shared with.","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"beginaligned\nh = ( v_blue d_0d_1) w_0) d_1d_2) w_0w_1) d_2) w_0w_2) )\n      ( v_yellow d_1d_2) w_1) )\n      ( v_red d_2) w_2) )  \nc_i = ( v_blue)\nc_2 = ( v_yellow )\nc_3 = ( v_blue v_yellow v_red)\nendaligned","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"This is syntactic sugar, but looks better to a programmer, who fears redundancy. But better still  this notation suggests another simplification, by using ranges of versions. Sets of subsequent, contingent (no holes in between) versions can be represented by ranges with the creating version as lower and the invalidating version as upper bound . For the intervals of components that persist,i.e. are not invalidated by a subsequent version, we introduce a pseudo version ∞, which is the greatest upper bound and denotes not invalidated by an exisiting version. This is another joy for the programmer, because creating new versions of the aggregate can be done without updating the upper bounds of intervals of unchanged components.","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"beginaligned\nh =  ( v_blue d_0d_1) w_0) d_1d_2) w_0w_1) d_2) w_0w_2) )\n      ( v_yellow d_1d_2) w_1) )\n      ( v_red d_2) w_2) ) \nc_i = v_bluev_yellow)\nc_2 = v_yellowv_red)\nc_3 = v_blue v_)\nendaligned","category":"page"},{"location":"api/theory/#Textual-representation-of-mutation-histories","page":"Theory","title":"Textual representation of mutation histories","text":"","category":"section"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"A practically interesting aspect of a history of mutations is, which mutations are made to represent consecutive changes of the domain and which ones are retrospective corrections. This can be represented by a tree of vectors of version nodes where","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"nodes in one vector denote consecutive mutations and\nchild node vectors denote mutations which have been retrospectively corrected by their predecessor","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"textlet \nbeginaligned\ni=(t_0t_1)t_2t_3)) \nshadowed(i) = (d_lowerd_upper) w_lowerw_upper)  d_upper = t_0 land w_lowerw_upper) cap t_2t_3) = w_lowerw_upper) \nendaligned","category":"page"},{"location":"api/theory/#textual-represention-of-our-example","page":"Theory","title":"textual represention of our example","text":"","category":"section"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"red\nyellow\nblue","category":"page"},{"location":"api/theory/#Bitemporal-Transactions","page":"Theory","title":"Bitemporal Transactions","text":"","category":"section"},{"location":"api/theory/#Transaction-data,-commits-and-rollbacks","page":"Theory","title":"Transaction data, commits and rollbacks","text":"","category":"section"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"Transactions here are application based. A transaction is identified by a version and transaction data that depend on it.","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"Beginning a transaction on a bitemporal aggregate now as of a date of reference w means","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"to create a version object and\nan interval of validity labelled as not committed and","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"hspace*10mm validity = now) w)","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"with retrospective transactions\nall revisions valid from now shadowed versions on are marked as invalid from the new version on and\nall revisions invalid from now shadowed versions on are revived (copied) and marked as valid from the new version on\nThese actions can be implemented by database constraints.","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"Mutations of components consist of","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"new revisions of components that are marked as valid from the new version on and invalid from infinity on and\nprevious revisions of mutated or deleted components that are marked as invalid from the new version on.","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"Backing out of a bitemporal transaction consists of","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"deleting the version instance and its depending data:\nthe uncommitted interval\nnew revisions of components, which are marked as valid from the backed out version on – which may be\nexplicitly inserted or mutated or\nimplicitly inserted (revived) in the beginning of a retrospective transaction\nresetting the \"invalid from\" marks of mutated and shadowed revisions back to infinity(MaxVersion)","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"Committing  a version consists of","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"labelling its interval of validity as committed\nand managing shadowing and overlapping of its interval of validity with those of previous versions as is described in above examples.","category":"page"},{"location":"api/theory/#Locking","page":"Theory","title":"Locking","text":"","category":"section"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"Application defined locking is based on a constraint that per entity only one interval with state uncommitted may exist.","category":"page"},{"location":"api/theory/#Reified-transactions-and-workflow","page":"Theory","title":"Reified transactions and workflow","text":"","category":"section"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"As transactions in this framework are first class data they can be utilized for workflow control:","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"As results of transactionaal operations are persisted immediately, they existence does not depend on the process they are initiated in. The process can be ended before commit and the workflow can resumed later in another process.\nWith concepts of ownership of workflow and state of work added, transactions with state of work = suspended marked can  be delegated between owners by suspending and resuming in their respective processes.","category":"page"},{"location":"api/theory/#GiST-indexing-in-POSTGRES-for-search-and-guarding-bitemporal-uniqueness","page":"Theory","title":"GiST indexing in POSTGRES for search and guarding bitemporal uniqueness","text":"","category":"section"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"Database access to bitemporal objects can be supported by GiST (Generalized Search Tree) indices on our","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"timestamp-intervals for database and world validity as well as\nrevision intervals","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"So in POSTGRES, for example - hava a look at the UML-Diagram below - , we can access a component (with table name PART) by a simple join with filters that locate","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"a history's version by inclusion of the database and world timestamp in thedatabase and world validity intervals and\na PART's revision by the version id's inclusion in the PART_REVISION's range of valid versions.","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"<pre><code>SELECT * FROM histories h\nJOIN version v ON v.ref_history = h.id\nJOIN validity_interval i ON i.ref_version = v.id \nJOIN <i>PART</i> p ON p.ref_history\nJOIN <i>PART_REVISION</i> r ON r.ref_<i>PART</i> = p.id AND r.validity_range  @> v.id\nWHERE h.id = :history_id and p.id = :part_id AND i.tsr_world @> TIMESTAMPTZ:ts_world and i.tsr_db @> TIMESTAMPTZ :ts_db\n</code></pre>","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"POSTGRES also provides uniqueness constraints for GIST-indices, so that we can guarantee for every history, that its versions validity_intervals are unique, that is non overlapping. Inserting an overlapping interval fails constraint violation exception.","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"<pre><code>ADD CONSTRAINT bitemp EXCLUDE USING GIST (ref_version WITH =, is_committed WITH =, tsrworld WITH &&, tsrdb WITH &&)`\n</code></pre>","category":"page"},{"location":"api/theory/#A-first-sketch-of-a-bitemporal-UML-model-for-insurance-contracts","page":"Theory","title":"A first sketch of a bitemporal UML model for insurance contracts","text":"","category":"section"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"(Image: UML Model)","category":"page"},{"location":"api/theory/","page":"Theory","title":"Theory","text":"Please compare: https://hdombrovskaya.wordpress.com/2019/07/14/lets-go-bitemporal/ https://www.postgresql.eu/events/pgdayparis2019/sessions/session/2291/slides/171/pgdayparis2019msedivy_bitemporality.pdf","category":"page"},{"location":"#BitemporalPostgres.jl","page":"Home","title":"BitemporalPostgres.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"BitemporalPostgres provides an API for application based bitemporal transactions. These are \"long\" transactions, with persistent transaction data that is, so they serve as  basis of workflow management.","category":"page"},{"location":"","page":"Home","title":"Home","text":"For theory behind this, see the theory page.","category":"page"},{"location":"#Index","page":"Home","title":"Index","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"}]
}
