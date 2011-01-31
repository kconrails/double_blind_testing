RSpec::Matchers.define :validate_presence_of do |expected, options|
  match do |actual|
    object.send("#{expected}=", value(options))
    object.valid?
    object.errors[expected].should_not include(error_message)

    object.send("#{expected}=", nil)
    object.should_not be_valid
    object.errors[expected].should include(error_message)

    object.send("#{expected}=", '')
    object.should_not be_valid
    object.errors[expected].should include(error_message)
  end

  failure_message_for_should do |actual|
    %(expected #{object.class}'s #{expected} errors to contain "#{error_message}")
  end

  failure_message_for_should_not do |actual|
    %(expected #{object.class}'s #{expected} errors not to contain "#{error_message}")
  end

  description do
    "validate the presence of #{expected}"
  end
  
  def error_message
    "can't be blank"
  end
  
  def object
    return @object if defined?(@object)
    @object = actual.is_a?(Class) ? actual.new : actual
  end
  
  def value options
    return @value if defined?(@value)
    @value = options.is_a?(Hash) && options.has_key?(:with) ? options[:with] : 'x'
  end
end