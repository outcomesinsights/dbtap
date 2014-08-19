module Dbtap
  # Parent class to all classes that provide some sort of test
  #
  # Child classes must provide an <tt>ok?</tt> method which returns
  # true if the test passes, or false otherwise
  #
  # Child classes can opt to provide an <tt>errors</tt> method with
  # should return a string with any error information relavent to the test
  class Tester
    attr :name

    def is_ok?
      ok?
    rescue
      puts "Bail out! #{$!.message}"
      puts $!.backtrace.join("\n")
      raise
    end
  end
end

