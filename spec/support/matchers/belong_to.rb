RSpec::Matchers.define :belong_to do |expected, options|
  @options = {}
  @options.merge!(options) if options.is_a?(Hash)
  
  @attribute = expected
  
  match do |actual|
    @result = true

    if @options.has_key?(:object)
      @object = @options[:object]
    elsif defined?(Factory)
      class_name = actual.is_a?(Class) ? actual.name : actual.class.name
      class_symbol = class_name.underscore.to_sym

      @object = create_by_factory class_symbol
    else
      check false, "If you don't have factory_girl installed you must specify the primary object with :object => object"
    end

    if @options.has_key?(:association)
      @association = @options[:association]
    elsif defined?(Factory)
      @association = create_by_factory @attribute
    else
      check false, "If you don't have factory_girl installed you must specify the association with :association => object"
    end

    check @object.valid?, "#{@object.class} instance is not valid"
    check @association.valid?, "#{@assocation.class} association is not valid"

    @object.send("#{@attribute}=", nil)
    check @object.send(@attribute).nil?, "#{@attribute} has a value before being set"
    
    @object.send("#{@attribute}=", @association)
    check @object.send(@attribute) == @association, "#{@attribute} was not set properly"

    check @object.send("#{@attribute}_id") == @association.id, "#{@attribute}_id was not set properly"

    @result
  end

  failure_message_for_should do |actual|
    %(expected #{@object.class} to belong to #{@attributes}, but #{@error_messages.join(', ')}")
  end

  failure_message_for_should_not do |actual|
    %(expected #{@object.class} not to belong to #{@attributes}, but #{@error_messages.join(', ')}")
  end

  description do
    "belong to #{@attributes}"
  end
  
  def check expression, message
    @error_messages ||= []
    
    unless expression
      @result = false
      @error_messages << message
    end
  end

  def create_by_factory object_sym
    if Factory.factories.keys.include?(object_sym)
      return Factory.create(object_sym)
    else
      check false, "You don't have a #{@attribute} factory defined"
    end
  end
end