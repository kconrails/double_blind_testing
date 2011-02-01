RSpec::Matchers.define :set_default_for do |expected, options|
  @options = {:to => nil}
  @options.merge!(options) if options.is_a?(Hash)
  
  @attribute = expected
  
  match do |actual|
    klass = actual.is_a?(Class) ? actual : actual.class
    @result = true
    
    @object = klass.new @attribute => nil
    check @object.send(@attribute).nil?, "was not able to set to nil"

    @object = klass.new @attribute => ""
    check @object.send(@attribute).blank?, "was not able to set to blank"

    @object = klass.new @attribute => @options[:to] * 2
    check @object.send(@attribute) == @options[:to] * 2, "was not able to set to a different value"

    @object = klass.new
    check @object.send(@attribute) == @options[:to], "it defaulted to #{string_for @object.send(@attribute)} instead"

    @result
  end

  failure_message_for_should do |actual|
    %(expected #{@object.class}'s #{@attribute} to default to #{@options[:to]}, but #{@error_messages.join(', ')}")
  end

  failure_message_for_should_not do |actual|
    %(expected #{@object.class}'s #{@attribute} to not default to #{@options[:to]}, but #{@error_messages.join(', ')}")
  end

  description do
    "set default for #{@attribute} to #{@options[:to]}"
  end
  
  def check expression, message
    @error_messages ||= []
    
    unless expression
      @result = false
      @error_messages << message
    end
  end
  
  def string_for value
    return 'nil' if value.nil?
    return 'blank' if value.blank?
    
    value.to_s
  end
end