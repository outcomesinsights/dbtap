# Use the `dbtap` command line utility to run this file, e.g.:
# bundle exec dbtap run_test examples/basic_example.rb
define_tests do
  set_eq(db[:person], db[:person], 'person should equal self')
  performs_within(db[:person], 1.0, 0.99999, 'person should be quick')
end

define_tests do
  set_eq(db['SELECT * FROM "person"'], db[:person], 'person should equal text-based self')
  set_eq(db['SELECT * FROM "person"'], db['SELECT * FROM "person"'], 'text-based person should equal text-based self')
  set_eq(db[:person], db[:person].limit(1), 'person should equal self')
  performs_within(db[:person], 1.0, 0.99999, 'person should be quick')
end
