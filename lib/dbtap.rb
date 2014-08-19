require "dbtap/version"
require "dbtap/tapper"

module Dbtap
  # Starts a new set of tests.  Use like so:
  #
  #   require 'dbtap'
  #   include Dbtap
  #
  #   define_tests do
  #     set_eq(db[:table], db['select * from table'],
  #       'Sequel selects all from table')
  #     # Your other tests here
  #   end
  #
  # Within the block, `db` is defined as a Sequel-based connection
  # to your database as defined by your Sequelizer configuration
  def define_tests(&block)
    t = Tapper.new
    t.instance_eval(&block)
    t.run
  end
end
