# Use the `dbtap` command line utility to run this file, e.g.:
# bundle exec dbtap run_test examples/basic_example.rb

# Start defining a set of tests
define_tests do
  # Test if these two queries return the same set of rows
  set_eq(db[:person], db[:person], 'person should equal self')
  # See if this query runs within 1.0 seconds (plus or minus 0.99999)
  performs_within(db[:person], 1.0, 0.99999, 'person should be quick')
end

# Define another set of results
define_tests do
  set_eq(db['SELECT * FROM "person"'], db[:person], 'person should equal text-based self')
  set_eq(db['SELECT * FROM "person"'], db['SELECT * FROM "person"'], 'text-based person should equal text-based self')
  set_eq(db[:person], db[:person].limit(1), 'person should equal self')
  performs_within(db[:person], 1.0, 0.99999, 'person should be quick')
end
