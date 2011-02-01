module DoubleBlindMatchers
  class SetDefaultFor < CustomMatcher
    def match
      klass = @object.class

      @object = klass.new @attribute => nil
      check @object.send(@attribute).nil?, "was not able to set to nil"

      @object = klass.new @attribute => ""
      check @object.send(@attribute).blank?, "was not able to set to blank"

      @object = klass.new @attribute => @options[:to] * 2
      check @object.send(@attribute) == @options[:to] * 2, "was not able to set to a different value"

      @object = klass.new
      check @object.send(@attribute) == @options[:to], "it defaulted to #{string_for @object.send(@attribute)} instead"
    end

    def failure_message_for_should
      %(expected #{@object.class}'s #{@attribute} to default to #{@options[:to]}, but #{@error_messages.join(', ')}")
    end

    def failure_message_for_should_not
      %(expected #{@object.class}'s #{@attribute} to not default to #{@options[:to]}, but #{@error_messages.join(', ')}")
    end
  
    def string_for value
      return 'nil' if value.nil?
      return 'blank' if value.blank?
    
      value.to_s
    end
  end
  
  def set_default_for expected, options = {}
    SetDefaultFor.new expected, options
  end
end