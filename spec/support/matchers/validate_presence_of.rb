RSpec::Matchers.define :validate_presence_of do |expected, options|
  @options = {:message => "can't be blank", :with => 'x'}
  @options.merge!(options) if options.is_a?(Hash)
  
  @attribute = expected
  
  match do |actual|
    set_to @options[:with]
    object.valid?
    object.errors[@attribute].should_not include(@options[:message])

    set_to nil
    object.should_not be_valid
    object.errors[@attribute].should include(@options[:message])

    set_to ""
    object.should_not be_valid
    object.errors[@attribute].should include(@options[:message])
  end

  failure_message_for_should do |actual|
    %(expected #{object.class}'s #{@attribute} errors to contain "#{@options[:message]}")
  end

  failure_message_for_should_not do |actual|
    %(expected #{object.class}'s #{@attribute} errors not to contain "#{@options[:message]}")
  end

  description do
    "validate the presence of #{@attribute}"
  end
  
  def object
    return @object if defined?(@object)
    @object = actual.is_a?(Class) ? actual.new : actual
  end
  
  def set_to value
    object.send("#{@attribute}=", value)
  end
end