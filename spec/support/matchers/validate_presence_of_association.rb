RSpec::Matchers.define :validate_presence_of_association do |expected, options|
  @options = {:message => "can't be blank"}
  @options.merge!(options) if options.is_a?(Hash)

  @attribute = expected
  @association = @options[:association] || Factory.create(@attribute)
  
  match do |actual|
    if @options.has_key?(:object)
      @object = @options[:object]
    else
      class_name = actual.is_a?(Class) ? actual.name : actual.class.name
      class_symbol = class_name.underscore.to_sym
      
      @object = Factory.create(class_symbol, @attribute => @association)
    end
      
    @result = true
    
    @object.valid?
    @result &&= !@object.errors[@attribute].include?(@options[:message])
    
    set_to nil
    @result &&= !@object.valid?
    @result &&= @object.errors[@attribute].include?(@options[:message])

    @result
  end

  failure_message_for_should do |actual|
    %(expected #{@object.class}'s #{@attribute} errors #{error_list}\nto contain "#{@options[:message]}")
  end

  failure_message_for_should_not do |actual|
    %(expected #{@object.class}'s #{@attribute} errors #{error_list}\nnot to contain "#{@options[:message]}")
  end

  description do
    "validate the presence of #{@attribute}"
  end
  
  def set_to value
    @object.send("#{@attribute}=", value)
  end
  
  def error_list
    return @error_list if defined?(@error_list)
    @error_list = '[' + @object.errors[@attribute].map{|error| %("#{error}") }.join(', ') + ']'
  end
end