require 'benchmark'
require_relative 'tester'

module Dbtap
  # Tests if a query performs within a certain period of time.
  #
  # Each query is run ten times and
  #
  # This is useful for benchmarking, and will verify that a query ran
  # neither too slow nor too fast.
  class PerformsWithin < Tester
    attr :expected_time, :query, :elapsed_time, :delta
    # +query+ - The query to benchmark
    # +expected_time+ - The average expected time to run the query once (in milliseconds)
    # +delta+ - The amount of time + or - that the query is allowed to deviate (in milliseconds)
    # +name+ - (optional) the name of the test
    def initialize(query, expected_time, delta, name = nil)
      @name = name
      @query = query
      @expected_time = expected_time
      @delta = delta
    end

    def ok?
      time_diff.abs.to_f <= delta
    end

    def errors
      output = []
      output << "  average runtime: #{elapsed_time} ms"
      output << "  desired average: #{expected_time} +/- #{delta} ms"

      output.join("\n")
    end

    private
    def elapsed_time
      @elapsed_time ||= bench_it / repetitions.to_f
    end

    def bench_it
      Benchmark.realtime do
        repetitions.times do
          query.count
        end
      end
    end

    def repetitions
      10
    end

    def time_diff
      expected_time - elapsed_time
    end
  end
end
