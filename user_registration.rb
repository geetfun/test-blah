%w( rubygems sinatra builder faster_xml_simple models/user_registration ).each do |lib|
  require lib
end

enable :clean_trace
disable :show_exceptions

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

post "/user_registrations.xml" do
  begin
    # error handling for incorrect XML
    
    # parsing the incoming XML    
    doc = FasterXmlSimple.xml_in(@request.body.read)
    doc = doc['register-user']
    
    # error handling for incomplete variables
 
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
      content_type :xml
      builder :'errors/active_resource_errors', :locals => @model_errors
    end
    
  rescue LibXML::XML::Error => e
    status(201)
    "Hello World"
  rescue Sequel::DatabaseError => e
    status(422)
    content_type :xml
    builder :'errors/general'
  rescue RuntimeError => e
    status(422)
    content_type :xml
    builder :'errors/general'
    raise "Ugh: #{e}"
  end
end