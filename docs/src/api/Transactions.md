## Application based transaction logic
### transaction isolation
Committed versions are immutable data and ergo
need no transaction isolation.
### pending transactions' data
* 1 Workflow instance
* 1 Version instance
* 1 Validity interval instance. Value of is_committed=0
* New components. ref_version 
* New revisions of new of mutated components. ref_validfrom = v
* Previous revisions of mutated or deleted components have value if ref_invalidfrom= v

#### rollback
Deletion of the version instance cascade deletes all of the above mentioned new instances
And resets the ref_invalidfrom fields to \infinity
### commit
