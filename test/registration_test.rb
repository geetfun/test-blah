require 'rubygems'
require 'test/unit'
require 'rack/test'
require File.join(File.dirname(__FILE__), '..', 'register_user')

set :environment, :test

class RegisterUserTest < Test::Unit::TestCase
  include Rack::Test::Methods
  
  def app
    Sinatra::Application
  end
  
  #
  # Testing invalid routes
  #
  def test_it_does_not_respond_to_get
    get '/'
    assert !last_response.ok?
  end
  
  def test_it_does_not_respond_to_put
    put '/'
    assert !last_response.ok?
  end
  
  def test_it_does_not_respond_to_delete
    post '/' 
    assert !last_response.ok?    
  end
  
  #
  # Testing post route
  #
  def test_post_with_no_attributes_will_return_error
    post '/register_users.xml'
    assert last_response.ok?
  end
end