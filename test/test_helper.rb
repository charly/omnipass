# require 'mark'
# require 'minitest/unit'
require 'minitest/autorun'
require 'minitest/pride'
require "active_record"
# require "virtus"
require "pry"
require_relative "../lib/omnipass"

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:"
)

ActiveRecord::Schema.define do
  self.verbose = false
  create_table :authentications, force: true do |t|
    t.string :uid
    t.string :provider
    t.string :email
    t.integer :account_id

    t.timestamps
  end

  create_table :accounts, force: true do |t|
    t.string :email
    t.integer :account_id

    t.timestamps
  end

  create_table :omnipass_emails, force: true do |t|
    t.string :email
    t.string :password_digest

    t.timestamps
  end

end
