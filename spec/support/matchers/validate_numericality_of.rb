RSpec::Matchers.define :validate_numericality_of do |expected, options|
  @options = {:message => "is not a number"}
  @options.merge!(options) if options.is_a?(Hash)
  
  @attribute = expected
  
  match do |actual|
    @object = actual.is_a?(Class) ? actual.new : actual
    @result = true
    
    validations = [
      :greater_than_or_equal_to, :greater_than,
      :less_than_or_equal_to, :less_than,
      :equal_to, :even, :odd
    ]
    
    validations.each do |validation|
      send "validate_#{validation}", @options[validation] if @options.has_key?(validation)
    end
  end

  failure_message_for_should do |actual|
    %(expected #{@object.class}'s #{@attribute} errors #{error_list}\nto contain "#{@options[:message]}")
  end

  failure_message_for_should_not do |actual|
    %(expected #{@object.class}'s #{@attribute} errors #{error_list}\nnot to contain "#{@options[:message]}")
  end

  description do
    "validate the length of #{@attribute}"
  end
  
  def validate_greater_than_or_equal_to minimum
    set_to minimum
    @object.valid?
    @result &&= !@object.errors[@attribute].include?(@options[:message])
    
    set_to minimum - 1
    @result &&= !@object.valid?
    @result &&= @object.errors[@attribute].include?(@options[:message])
  end
  
  def validate_greater_than under_minimum
    validate_greater_than_or_equal_to under_minimum + 1
  end
  
  def validate_less_than_or_equal_to maximum
    set_to maximum
    @object.valid?
    @result &&= !@object.errors[@attribute].include?(@options[:message])
    
    set_to maximum + 1
    @result &&= !@object.valid?
    @result &&= @object.errors[@attribute].include?(@options[:message])
  end
  
  def validate_less_than over_maximum
    validate_less_than_or_equal_to over_maximum - 1
  end
  
  def validate_equal_to value
    set_to value
    @object.valid?
    @result &&= !@object.errors[@attribute].include?(@options[:message])
    
    set_to value + 1
    @result &&= !@object.valid?
    @result &&= @object.errors[@attribute].include?(@options[:message])
    
    set_to value - 1
    @result &&= !@object.valid?
    @result &&= @object.errors[@attribute].include?(@options[:message])
  end
  
  def validate_within range
    minimum, maximum = [range.first, range.last].sort
    
    validate_greater_than_or_equal_to minimum
    validate_less_than_or_equal_to maximum
  end
  
  def validate_odd
    [1, 3, 5, 7, 9].each do |value|
      set_to value
      @object.valid?
      @result &&= !@object.errors[@attribute].include?(@options[:message])
    end
    
    [0, 2, 4, 6, 8].each do |value|
      set_to value
      @result &&= !@object.valid?
      @result &&= @object.errors[@attribute].include?(@options[:message])
    end
  end
  
  def validate_even
    [0, 2, 4, 6, 8].each do |value|
      set_to value
      @object.valid?
      @result &&= !@object.errors[@attribute].include?(@options[:message])
    end
    
    [1, 3, 5, 7, 9].each do |value|
      set_to value
      @result &&= !@object.valid?
      @result &&= @object.errors[@attribute].include?(@options[:message])
    end
  end
  
  def set_to value
    @object.send("#{@attribute}=", value)
  end
  
  def error_list
    return @error_list if defined?(@error_list)
    @error_list = '[' + @object.errors[@attribute].map{|error| %("#{error}") }.join(', ') + ']'
  end
end