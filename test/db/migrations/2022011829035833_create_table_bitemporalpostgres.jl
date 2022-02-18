module BitemporalPostgresDDL
import SearchLight: query
import SearchLight.Migrations: create_table, column, columns, primary_key, add_index, drop_table, add_indices
import TimeZones
using SearchLight, TimeZones
export  create_versions_trigger, create_validity_intervals_constraints, up, down

"""
create_versions_trigger()
  propagate skalars ref_validfrom and ref_invalidfrom to range ref_valid
  skalars are needed enable foreign key constraints, which in POSTGRES cannot be declared
  onto bounds of intervals directly.
"""
function create_versions_trigger() 
  q = """
  CREATE OR REPLACE FUNCTION f_versionrange ()
  RETURNS trigger AS
  \$\$
       DECLARE
  
       BEGIN
            RAISE NOTICE 'NEW: %', NEW;
            NEW.ref_valid := int8range(NEW.ref_validfrom,NEW.ref_invalidfrom,'[)');
            RETURN NEW;
       END;
  \$\$ LANGUAGE 'plpgsql';
  """
  SearchLight.query(q)
end

"""
create_validity_intervals_constraints()
  Install the GIST constraint that prevents creation of overlapping intervals, i.e.
  that at most one version is valid for a given 2 dimensional point in transaction and reference time
"""
function create_validity_intervals_constraints() 
  q="""
  ALTER TABLE validityIntervals 
  ADD CONSTRAINT bitemp EXCLUDE USING GIST (ref_version WITH =, is_committed WITH =, tsrworld WITH &&, tsrdb WITH &&)
  """
  SearchLight.query(q)
end

"""
up()
callback from SearchLight.Migrations.up 
creating the Database Schema for bitemporal Transactions
including test dummy tables
"""
function up()
  createGistExtension = "CREATE EXTENSION IF NOT EXISTS btree_gist;"
  
  create_table(:histories) do
    [
      column(:id,:bigserial,"PRIMARY KEY")
      column(:dummy, :integer)
    ]
  end

  create_table(:versions) do
    [
      column(:id,:bigserial,"PRIMARY KEY")
      column(:ref_history, :integer,"REFERENCES histories(id) ON DELETE CASCADE")
    ]
  end

  
  create_table(:workflows) do
    [
      column(:id,:bigserial,"PRIMARY KEY")
      column(:ref_history, :integer,"REFERENCES histories(id) ON DELETE CASCADE")
      column(:ref_version, :integer,"REFERENCES versions(id) ON DELETE CASCADE")
      column(:tsw_validfrom, :timestamptz,"(3)")
      column(:tsdb_validfrom, :timestamptz,"(3)")
      column(:is_committed, :integer)
    ]
  end

  create_table(:testtstzranges) do
    [
      column(:id,:bigserial,"PRIMARY KEY")
      column(:i, :tstzrange)
    ]
  end
  
  create_table(:validityIntervals) do
      [
        column(:id,:bigserial,"PRIMARY KEY")
        column(:ref_history, :integer,"REFERENCES histories(id) ON DELETE CASCADE")
        column(:ref_version, :integer,"REFERENCES versions(id) ON DELETE CASCADE")
        column(:tsrworld, :tstzrange)
        column(:tsrdb, :tstzrange) 
        column(:is_committed, :integer)
      ]
  end

  create_table(:testdummyComponents) do
    [
      column(:id,:bigserial,"PRIMARY KEY")
      column(:ref_history, :integer,"REFERENCES histories(id) ON DELETE CASCADE")
    ]
    end
  
    create_table(:testdummyComponentRevisions) do
      [
        column(:id,:bigserial,"PRIMARY KEY")
        column(:ref_component, :integer, "REFERENCES testdummyComponents(id) ON DELETE CASCADE")
        column(:ref_validfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
        column(:ref_invalidfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
        column(:ref_valid, :int8range)
        column(:description, :string)
      ]
    end
      
  create_table(:testdummySubComponents) do
    [
      column(:id,:bigserial,"PRIMARY KEY")
      column(:ref_history, :integer,"REFERENCES testdummyComponents(id) ON DELETE CASCADE") 
      column(:ref_super, :integer,"REFERENCES histories(id) ON DELETE CASCADE")
    ]
    end
  
    create_table(:testdummySubComponentRevisions) do
      [
        column(:id,:bigserial,"PRIMARY KEY")
        column(:ref_component, :integer, "REFERENCES testdummySubComponents(id) ON DELETE CASCADE")
        column(:ref_validfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
        column(:ref_invalidfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
        column(:ref_valid, :int8range)
        column(:description, :string)
      ]
    end

    createTestdummyComponentRevisionsTrigger = """
    CREATE TRIGGER tr_versions_trig
    BEFORE INSERT OR UPDATE ON testdummyComponentRevisions
    FOR EACH ROW EXECUTE PROCEDURE f_versionrange();
    """
  
    createTestdummyComponentRevisionsConstraints = """
    ALTER TABLE testdummycomponentrevisions 
    ADD CONSTRAINT testdummycomponentrevisionsversionrange EXCLUDE USING GIST (ref_component WITH =, ref_valid WITH &&)
    """
    
    createTestdummySubComponentRevisionsTrigger = """
    CREATE TRIGGER tr_versions_trig
    BEFORE INSERT OR UPDATE ON testdummySubComponentRevisions
    FOR EACH ROW EXECUTE PROCEDURE f_versionrange();
    """
  
    createTestdummySubComponentRevisionsConstraints = """
    ALTER TABLE testdummySubComponentrevisions 
    ADD CONSTRAINT testdummysubcomponentrevisionsversionrange EXCLUDE USING GIST (ref_component WITH =, ref_valid WITH &&)
    """


SearchLight.query(createGistExtension)
create_validity_intervals_constraints()
create_versions_trigger()
SearchLight.query(createTestdummyComponentRevisionsTrigger)
SearchLight.query(createTestdummyComponentRevisionsConstraints)
SearchLight.query(createTestdummySubComponentRevisionsTrigger)
SearchLight.query(createTestdummySubComponentRevisionsConstraints)
maxDate =  ZonedDateTime(DateTime(2038, 1, 19,14,7), tz"UTC")
maxDateSQL = SQLInput(maxDate)
infinityKey = 9223372036854775807 ::Integer

SearchLight.query("""
INSERT INTO histories VALUES($infinityKey,0)
"""
)
SearchLight.query("""
INSERT INTO versions VALUES($infinityKey)
"""
)
  
end

"""
down()
callback from SearchLight.Migrations.down 
tearing down the Database Schema for bitemproal Transactions
including test dummy tables
"""
function down()
  drop_table(:testdummySubComponentRevisions)
  drop_table(:testdummySubComponents)
  drop_table(:testdummyComponentRevisions)
  drop_table(:testdummyComponents)
  drop_table(:validityIntervals)
  drop_table(:workflows)
  drop_table(:versions)
  drop_table(:histories)
end
end