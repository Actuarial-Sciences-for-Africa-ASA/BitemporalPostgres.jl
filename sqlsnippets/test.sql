select * from validityintervals where ref_history=1
--AND tsrdb @> TIMESTAMPTZ E'2038-01-19T03:14:06.999+00:00' 
and tsrworld <@ tstzrange(E'2014-11-30T20:00:01.001+00:00',E'2038-01-19T03:14:06.999+00:00')