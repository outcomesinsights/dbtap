require 'csv'
require_relative 'tester'

module Dbtap
  # Tests to see if two sets of results are equal
  #
  # Sets is a bit of a misnomer in that if a query returns duplicate rows,
  # those rows are NOT deduplicated.
  #
  # The order in which either query returns the results is ignored when testing
  # for equality.
  class SetEq < Tester
    attr :actual, :expected

    # +actual+ - The query being tested
    # +expected+ - The set of results expected.  Should be another query.
    # +name+ - (optional) the name of the test
    def initialize(actual, expected, name = nil)
      @name = name
      @actual = actual
      @expected = expected
    end

    def ok?
      missing.empty? && extras.empty?
    end

    def errors
      drop_csv
      output = []
      unless missing.empty?
        output << "Missing #{missing.count}/#{expected_count} Records:"
        output << '  ' + missing.first.inspect
      end

      unless extras.empty?
        output << "Extra #{extras.count} over #{expected_count} Records:"
        output << '  ' + extras.first.inspect
      end
    end

    private
    def missing
      @missing ||= expected.except(actual).all
    end

    def extras
      @extras ||= actual.except(expected).all
    end

    def expected_count
      @expected_count = expected.count
    end

    def drop_csv
      rows = actual.all
      CSV.open('/tmp/actual.csv', 'w') do |csv|
        unless rows.empty?
          csv << rows.first.keys
        end

        rows.each do |row|
          csv << row.values
        end
      end
    end
  end
end
