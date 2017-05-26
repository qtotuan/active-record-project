require 'bundler/setup'
Bundler.require

require 'rake'
require 'active_record'
require 'yaml/store'
require 'ostruct'
require 'date'
require 'sqlite3'

DBNAME = "bookstore"

Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../lib/support", "*.rb")].each {|f| require f}
# require_relative '../bin/run.rb'
# binding.pry
# DBRegistry["development"].connect!
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/bookstore-development.db')
DB = ActiveRecord::Base.connection

# if ENV["ACTIVE_RECORD_ENV"] == "test"
#   ActiveRecord::Migration.verbose = false
# end
