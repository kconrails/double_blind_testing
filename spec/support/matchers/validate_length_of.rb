RSpec::Matchers.define :validate_length_of do |expected, options|
  match do |actual|
    string = 'x' * value(options)
    
    object.send("#{expected}=", string)
    object.valid?
    object.errors[expected].should_not include(error_message(options))

    object.send "#{expected}=", case value(options)
    when options[:maximum] then string + 'x'
    when options[:minimum] then string.chop
    end

    object.should_not be_valid
    object.errors[expected].should include(error_message(options))
  end

  failure_message_for_should do |actual|
    %(expected #{object.class}'s #{expected} errors to contain "#{error_message(options)}")
  end

  failure_message_for_should_not do |actual|
    %(expected #{object.class}'s #{expected} errors not to contain "#{error_message(options)}")
  end

  description do
    "validate the length of #{expected}"
  end
  
  def error_message options
    return @error_message if defined?(@error_message)
    @error_message = options.is_a?(Hash) && options.has_key?(:message) ? options[:message] : "is not the right length"
  end
  
  def object
    return @object if defined?(@object)
    @object = actual.is_a?(Class) ? actual.new : actual
  end
  
  def value options
    return @value if defined?(@value)
    @value = options.is_a?(Hash) ? (options[:maximum] || options[:minimum]) : 0
  end
end