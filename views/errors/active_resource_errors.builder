xml.instruct!
xml.errors :type => "Array" do
  @model_errors.each do |error|
    xml.error full_error_message(error)
  end
end