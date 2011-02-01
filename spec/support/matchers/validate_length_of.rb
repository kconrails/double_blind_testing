RSpec::Matchers.define :validate_length_of do |expected, options|
  @options = {:message => "is not the right length"}
  @options.merge!(options) if options.is_a?(Hash)
  
  @attribute = expected
  
  match do |actual|
    @object = actual.is_a?(Class) ? actual.new : actual
    @result = true

    validate_minimum_of(@options[:minimum]) if @options[:minimum]
    validate_maximum_of(@options[:maximum]) if @options[:maximum]
    validate_exact_length_of(@options[:is]) if @options[:is]
    validate_range_of(@options[:within]) if @options[:within]
    
    @result
  end

  failure_message_for_should do |actual|
    %(expected #{@object.class}'s #{@attribute} errors #{error_list}\nto contain: "#{@options[:message]}")
  end

  failure_message_for_should_not do |actual|
    %(expected #{@object.class}'s #{@attribute} errors #{error_list}\nnot to contain "#{@options[:message]}")
  end

  description do
    "validate the length of #{@attribute}"
  end
  
  def validate_minimum_of minimum
    string = 'x' * minimum
    
    set_to string
    @object.valid?
    @result &&= !@object.errors[@attribute].include?(@options[:message])

    set_to string.chop
    @result &&= !@object.valid?
    @result &&= @object.errors[@attribute].include?(@options[:message])
  end

  def validate_maximum_of maximum
    string = 'x' * maximum
    
    set_to string
    @object.valid?
    @result &&= !@object.errors[@attribute].include?(@options[:message])
    
    set_to string + 'x'
    @result &&= !@object.valid?
    @result &&= @object.errors[@attribute].include?(@options[:message])
  end
  
  def validate_exact_length_of length
    string = 'x' * length
    
    set_to string
    @object.valid?
    @result &&= !@object.errors[@attribute].include?(@options[:message])

    set_to string.chop
    @result &&= !@object.valid?
    @result &&= @object.errors[@attribute].include?(@options[:message])

    set_to string + 'xx'
    @result &&= !@object.valid?
    @result &&= @object.errors[@attribute].include?(@options[:message])
  end
  
  def validate_range_of range
    minimum, maximum = [range.first, range.last].sort
    
    @result &&= validate_minimum_of minimum
    @result &&= validate_maximum_of maximum
  end

  def set_to value
    @object.send("#{@attribute}=", value)
  end
  
  def error_list
    return @error_list if defined?(@error_list)
    @error_list = '[' + @object.errors[@attribute].map{|error| %("#{error}") }.join(', ') + ']'
  end
end