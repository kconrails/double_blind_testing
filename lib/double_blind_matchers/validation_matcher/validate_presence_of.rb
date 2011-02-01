module DoubleBlindMatchers
  class ValidatePresenceOf < ValidationMatcher
    def default_options
      {:message => "can't be blank", :with => 'x'}
    end

    def match
      set_to @options[:with]
      @object.valid?
      check !@object.errors[@attribute].include?(@options[:message]), shouldnt_exist
      
      set_to nil
      check !@object.valid?, valid_when('nil')
      check @object.errors[@attribute].include?(@options[:message])
      
      set_to ""
      check !@object.valid?, valid_when("blank")
      check @object.errors[@attribute].include?(@options[:message])
    end
  end
  
  def validate_presence_of expected, options = {}
    ValidatePresenceOf.new expected, options
  end
end