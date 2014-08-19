# Dbtap

Dbtap aims to eventually be a database-agnostic replacement for the __amazing__ [pgTAP](http://pgtap.org/)

## Why?

[One of my projects](https://github.com/outcomesinsights/conceptql) started off using PostgreSQL as its sole RDBMS.  I had employed pgTAP to run the [tests for that project](https://github.com/outcomesinsights/test_conceptql) and was __very__ happy.  But, sadly, other databases needed to be supported and so my tests would no longer run against those new RDBMSs.

But fortunately, [Sequel](http://sequel.jeremyevans.net/) exists and is great for writing database-agnostic SQL.  I am now porting over any functions I liked in pgTAP over into Dbtap.

I'll probably never need the majority of functions that pgTAP provides, meaning I won't be porting them over myself, but I'll update this library as my needs arise.

## Installation

Add this line to your application's Gemfile:

    gem 'dbtap'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dbtap


## Usage

1. Define a set of tests in a ruby file (see the examples directory)
2. Run that file using Dbtap's command line tool, `dbtap`
    - e.g. `dbtap run_file my_test_file.rb`
3. Marvel at the TAP-compatible output that issues forth


## Contributing

1. Fork it ( http://github.com/outcomesinsights/dbtap/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Thanks

- [Outcomes Insights, Inc.](http://outins.com)
    - Many thanks for allowing me to release a portion of my work as Open Source Software!
- David E. Wheeler
    - For writing [pgTAP](http://pgtap.org/)!
- Jeremy Evans
    - For writing [Sequel](http://sequel.jeremyevans.net/)!

## License
Released under the MIT license, Copyright (c) 2014 Outcomes Insights, Inc.
