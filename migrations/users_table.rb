# Custom migrations for users service

require 'rubygems'
require 'sequel'

DB = Sequel.connect('postgres://postgres:123moose@localhost:5432/scalerUsers_development')

DB.create_table! :users do
  primary_key :id
  column :email, :varchar, :size => 255, :unique => true, :null => false
  column :crypted_password, :varchar, :size => 255, :null => false
  column :password_salt, :varchar, :size => 255, :null => false
  boolean :active, :default => true, :null => false
  DateTime :last_login_at
  column :last_login_ip, :inet
  
  index :id
end