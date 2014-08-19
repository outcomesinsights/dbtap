require 'sequelizer'

module Dbtap
  # The Tapper class provides the DSL for Dbtap#define_tests
  #
  # It also drives the evaluation of all the tests via #run
  class Tapper
    include Sequelizer

    attr :tests
    def initialize
      @tests = []
    end

    # Drives the evaluation of each test, emitting TAP-compliant messages
    # for each test
    def run
      puts (1..tests.length).to_s
      tests.each_with_index do |test, i|
        if test.is_ok?
          ok(test, i)
        else
          not_ok(test, i)
        end
      end
    end

    private
    # Emits a TAP-compliant OK message
    def ok(test, i)
      message = "ok #{i + 1}"
      message += ' - ' + test.name if test.name
      puts message
    end

    # Emits a TAP-compliant NOT OK message
    def not_ok(test, i)
      message = "not ok #{i + 1}"
      message += ' - ' + test.name if test.name
      message += "\n  " + test.errors.split.join("\n  ") if test.errors
      puts message
    end

    # When dbtap is gem, this will require testers from the proper
    # relative path
    def local_require(file)
      path = base_dir + 'testers' + file.to_s
      require_relative path
    end

    # When we install dbtap as a gem, it will need to refer to the testers
    # directory, so we'll first find where the gem lives
    def base_dir
      Pathname.new(__FILE__).dirname
    end

    # The following methods are hard-coded, and used to instantiate
    # each type of test.  I imagine I can do some sort of thing where
    # each Tester class can register with Tapper to get dynamically create
    # a set of methods for Tapper to use, but for now, this is my approach
    def set_eq(*args)
      local_require(:set_eq)
      tests << SetEq.new(*args)
    end

    def performs_within(*args)
      local_require(:performs_within)
      tests << PerformsWithin.new(*args)
    end
  end
end

