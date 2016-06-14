# require 'mark'
# require 'minitest/unit'
require 'minitest/autorun'
require 'minitest/pride'
require "active_record"
require "virtus"
require_relative "../lib/paramount"

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:"
)

ActiveRecord::Schema.define do
  self.verbose = false
  create_table :books, force: true do |t|
    t.string :title
    t.timestamps
  end
end
