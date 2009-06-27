# Custom migrations for profiles service

require 'rubygems'
require 'sequel'

DB = Sequel.connect('postgres://postgres:123moose@localhost:5432/scalerUsers_development')

DB.create_table! :profiles do
  primary_key :id
  column :first_name, :varchar, :size => 100
  column :last_name, :varchar, :size => 100
  column :alias, :varchar, :size => 100
  column :title, :varchar, :size => 100
  column :name_prefix, :varchar, :size => 10
  column :user_id, :integer
end