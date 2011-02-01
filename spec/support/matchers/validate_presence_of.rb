RSpec::Matchers.define :validate_presence_of do |expected, options|
  @options = {:message => "can't be blank", :with => 'x'}
  @options.merge!(options) if options.is_a?(Hash)
  
  @attribute = expected
  
  match do |actual|
    @object = actual.is_a?(Class) ? actual.new : actual
    @result = true
    
    set_to @options[:with]
    @object.valid?
    check !@object.errors[@attribute].include?(@options[:message]), "didn't allow #{@options[:with]}"

    set_to nil
    check !@object.valid?, "was valid when nil"
    check @object.errors[@attribute].include?(@options[:message]), "it allowed nil"

    set_to ""
    check !@object.valid?, "was valid when blank"
    check @object.errors[@attribute].include?(@options[:message]), "it allowed blank"

    @result
  end

  failure_message_for_should do |actual|
    %(expected #{@object.class} to require #{@attribute}, but #{@error_messages.join(', ')}")
  end

  failure_message_for_should_not do |actual|
    %(expected #{@object.class} to not require #{@attribute}, but #{@error_messages.join(', ')}")
  end

  description do
    "validate the presence of #{@attribute}"
  end
  
  def set_to value
    @object.send("#{@attribute}=", value)
  end

  def check expression, message
    @error_messages ||= []
    
    unless expression
      @result = false
      @error_messages << message
    end
  end

  def error_list
    return @error_list if defined?(@error_list)
    @error_list = '[' + @object.errors[@attribute].map{|error| %("#{error}") }.join(', ') + ']'
  end
end