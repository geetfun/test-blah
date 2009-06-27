require 'sequel'

Sequel::Model.raise_on_save_failure = false
DB = Sequel.connect('postgres://postgres:123moose@localhost:5432/scalerUsers_development')