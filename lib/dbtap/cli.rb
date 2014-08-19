require 'thor'
require_relative '../dbtap'

module Dbtap
  class CLI < Thor
    include Dbtap

    desc 'run_test file1 [file2 ...]', 'runs tests in the selected file(s)'
    def run_test(*files)
      files.flatten.each do |file|
        instance_eval(File.read(file))
      end
    end
  end
end
