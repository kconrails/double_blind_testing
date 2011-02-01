RSpec::Matchers.define :have_many do |expected, options|
  @options = {}
  @options.merge!(options) if options.is_a?(Hash)
  
  @attributes = expected
  @attribute = @options[:singular] || @attributes.to_s.singularize.to_sym
  @association = @options[:association] || Factory.create(@attribute)
  
  match do |actual|
    if @options.has_key?(:object)
      @object = @options[:object]
    else
      class_name = actual.is_a?(Class) ? actual.name : actual.class.name
      class_symbol = class_name.underscore.to_sym
      
      @object = Factory.create(class_symbol)
    end

    @result = true

    check @object.valid?, "#{@object.class} instance was not valid"
    check @association.valid?, "#{@assocation.class} association was not valid"

    check !Array(@object.send(@attributes)).include?(@association), "#{@attributes} array prematurely includes #{@association.class} association"

    @object.send(@attributes) << @association
    check Array(@object.send(@attributes)).include?(@association), "#{@attributes} array doesn't include #{@association.class} association"

    @result
  end

  failure_message_for_should do |actual|
    %(expected #{@object.class} to have many #{@attributes}, but #{@error_messages.join(', ')}")
  end

  failure_message_for_should_not do |actual|
    %(expected #{@object.class} not to have many #{@attributes}, but #{@error_messages.join(', ')}")
  end

  description do
    "have many #{@attributes}"
  end
  
  def check expression, message
    @error_messages ||= []
    
    unless expression
      @result = false
      @error_messages << message
    end
  end
end