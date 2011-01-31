RSpec::Matchers.define :validate_length_of do |expected, options|
  @options = {:message => "is not the right length"}
  @options.merge!(options) if options.is_a?(Hash)
  
  @attribute = expected
  
  match do |actual|
    validate_minimum_of object, @options[:minimum] if @options[:minimum]
    validate_maximum_of object, @options[:maximum] if @options[:maximum]
    validate_exact_length_of object, @options[:is] if @options[:is]
    validate_range_of object, @options[:within] if @options[:within]
  end

  failure_message_for_should do |actual|
    %(expected #{object.class}'s #{@attribute} errors to contain "#{@options[:message]}")
  end

  failure_message_for_should_not do |actual|
    %(expected #{object.class}'s #{@attribute} errors not to contain "#{@options[:message]}")
  end

  description do
    "validate the length of #{@attribute}"
  end
  
  def validate_minimum_of object, minimum
    string = 'x' * minimum
    
    set_tostring
    object.valid?
    object.errors[@attribute].should_not include(@options[:message])

    set_to string.chop
    object.should_not be_valid
    object.errors[@attribute].should include(@options[:message])
  end

  def validate_maximum_of object, maximum
    string = 'x' * maximum
    
    set_to string
    object.valid?
    object.errors[@attribute].should_not include(@options[:message])

    set_to string + 'x'
    object.should_not be_valid
    object.errors[@attribute].should include(@options[:message])
  end
  
  def validate_exact_length_of object, length
    string = 'x' * length
    
    set_to string
    object.valid?
    object.errors[@attribute].should_not include(@options[:message])

    set_to string.chop
    object.should_not be_valid
    object.errors[@attribute].should include(@options[:message])

    set_to string + 'xx'
    object.should_not be_valid
    object.errors[@attribute].should include(@options[:message])
  end
  
  def validate_range_of object, range
    minimum, maximum = [range.first, range.last].sort
    
    validate_minimum_of object, minimum
    validate_maximum_of object, maximum
  end

  def object
    return @object if defined?(@object)
    @object = actual.is_a?(Class) ? actual.new : actual
  end
  
  def set_to value
    object.send("#{@attribute}=", value)
  end
end