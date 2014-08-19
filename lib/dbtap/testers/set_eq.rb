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
      output = []
      unless missing.empty?
        output << "Missing #{missing.count}/#{expected_count} Records:\n    " + missing.first.inspect
      end

      unless extras.empty?
        output << "Extra #{extras.count} over #{expected_count} Records:\n    " + extras.first.inspect
      end
      output.join("\n")
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
  end
end