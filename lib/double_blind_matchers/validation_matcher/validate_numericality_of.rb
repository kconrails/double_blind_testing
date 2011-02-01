module DoubleBlindMatchers
  class ValidateNumericalityOf < ValidationMatcher
    def default_options
      {:message => "is not a number"}
    end

    def match
      validations = [
        :greater_than_or_equal_to, :greater_than,
        :less_than_or_equal_to, :less_than,
        :equal_to, :even, :odd
      ]

      validations.each do |validation|
        send "validate_#{validation}", @options[validation] if @options.has_key?(validation)
      end
    end
    
    def validate_greater_than_or_equal_to minimum
      set_to minimum
      @object.valid?
      check !@object.errors[@attribute].include?(@options[:message]), shouldnt_exist

      set_to minimum - 1
      check !@object.valid?, valid_when("below #{minimum}")
      check @object.errors[@attribute].include?(@options[:message])
    end

    def validate_greater_than under_minimum
      validate_greater_than_or_equal_to under_minimum + 1
    end

    def validate_less_than_or_equal_to maximum
      set_to maximum
      @object.valid?
      check !@object.errors[@attribute].include?(@options[:message]), shouldnt_exist

      set_to maximum + 1
      check !@object.valid?, valid_when("above #{maximum}")
      check @object.errors[@attribute].include?(@options[:message])
    end

    def validate_less_than over_maximum
      validate_less_than_or_equal_to over_maximum - 1
    end

    def validate_equal_to value
      set_to value
      @object.valid?
      check !@object.errors[@attribute].include?(@options[:message]), shouldnt_exist

      set_to value + 1
      check !@object.valid?, valid_when("not #{value}")
      check @object.errors[@attribute].include?(@options[:message])

      set_to value - 1
      check !@object.valid?, valid_when("not #{value}")
      check @object.errors[@attribute].include?(@options[:message])
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
        check !@object.errors[@attribute].include?(@options[:message]), shouldnt_exist
      end

      [0, 2, 4, 6, 8].each do |value|
        set_to value
        check !@object.valid?, valid_when("even")
        check @object.errors[@attribute].include?(@options[:message])
      end
    end

    def validate_even
      [0, 2, 4, 6, 8].each do |value|
        set_to value
        @object.valid?
        check !@object.errors[@attribute].include?(@options[:message]), shouldnt_exist
      end

      [1, 3, 5, 7, 9].each do |value|
        set_to value
        check !@object.valid?, valid_when("odd")
        check @object.errors[@attribute].include?(@options[:message])
      end
    end
  end
  
  def validate_numericality_of expected, options = {}
    ValidateNumericalityOf.new expected, options
  end
end