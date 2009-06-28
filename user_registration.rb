%w( rubygems sinatra yaml builder lib/parser/xml lib/configuration/user_registration models/user_registration ).each do |lib|
  require lib
end

helpers do
  def full_error_message(error)
    raise ArgumentError if error.empty?
    error.flatten.join(' ').gsub(/_/, " ").capitalize
  end
  
  def assign_attribute(attribute_from_hash)
    return '' if ( attribute_from_hash == {} )
    attribute_from_hash
  end
end

before do
  content_type :xml
end

not_found do
  erb :'404'
end

post "/user_registrations.xml" do
  begin
    doc = Parser::Xml.parse(@request.body.read)
 
    user = User.new(
      :email => assign_attribute(doc['email']), 
      :password => assign_attribute(doc['password'])
      )
    if user.save
      status(201)
    else
      @model_errors = user.errors
      puts @model_errors
      status(422)
      builder :'errors/active_resource_errors', :locals => @model_errors
    end
    
  # rescue LibXML::XML::Error => e
  #   status(201)
  #   "Hello World"
  # rescue Sequel::DatabaseError => e
  #   status(422)
  #   builder :'errors/general'
  # rescue RuntimeError => e
  #   status(422)
  #   builder :'errors/general'
  #   raise "Ugh: #{e}"
  end
end