module DoubleBlindMatchers
  class ValidateLengthOf < ValidationMatcher
    def default_options
      {:message => "is not the right length"}
    end

    def match
      [:minimum, :maximum, :length, :range].each do |metric|
        send("validate_length_#{metric}", @options[metric]) if @options.has_key?(metric)
      end
    end
    
    def validate_length_minimum minimum
      string = 'x' * minimum

      set_to string
      @object.valid?
      check !@object.errors[@attribute].include?(@options[:message]), shouldnt_exist

      set_to string.chop
      check !@object.valid?, valid_when("too short")
      check @object.errors[@attribute].include?(@options[:message])
    end
    
    def validate_length_maximum maximum
      string = 'x' * maximum

      set_to string
      @object.valid?
      check !@object.errors[@attribute].include?(@options[:message]), shouldnt_exist

      set_to string + 'x'
      check !@object.valid?, valid_when("too long")
      check @object.errors[@attribute].include?(@options[:message])
    end

    def validate_length_is length
      string = 'x' * length

      set_to string
      @object.valid?
      check !@object.errors[@attribute].include?(@options[:message]), shouldnt_exist

      set_to string.chop
      check !@object.valid?, valid_when("too short")
      check @object.errors[@attribute].include?(@options[:message])

      set_to string + 'xx'
      check !@object.valid?, valid_when("too long")
      check @object.errors[@attribute].include?(@options[:message])
    end

    def validate_length_range range
      minimum, maximum = [range.first, range.last].sort

      validate_length_minimum minimum
      validate_length_maximum maximum
    end
  end
  
  def validate_length_of expected, options = {}
    ValidateLengthOf.new expected, options
  end
end