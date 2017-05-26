require_relative "./connection_adapter.rb"

DBRegistry = OpenStruct.new(development: ConnectionAdapter.new("db/#{DBNAME}-development.db"))
