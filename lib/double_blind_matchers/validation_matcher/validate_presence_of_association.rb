module DoubleBlindMatchers
  class ValidatePresenceOfAssociation < ValidationMatcher
    def default_options
      {:message => "can't be blank"}
    end

    def match
      @association = @options[:association] || create_by_factory(@attribute, :association)
      @object = @options[:object] || create_by_factory(class_symbol, :object, @attribute => @association)

      @object.valid?
      check !@object.errors[@attribute].include?(@options[:message]), shouldnt_exist

      set_to nil
      check !@object.valid?, valid_when("nil")
      check @object.errors[@attribute].include?(@options[:message])
    end
  end
  
  def validate_presence_of_association expected, options = {}
    ValidatePresenceOfAssociation.new expected, options
  end
end