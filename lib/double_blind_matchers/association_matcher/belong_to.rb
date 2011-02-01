module DoubleBlindMatchers
  class BelongTo < AssociationMatcher
    def match
      @association = @options[:association] || create_by_factory(@attribute, :association)
      @object = @options[:object] || create_by_factory(class_symbol)
      
      check @object.valid?, invalid(@object)
      check @association.valid?, invalid(@association)

      set_to nil
      check @object.send(@attribute).nil?, "#{@attribute} has a value before being set"

      set_to @association
      check @object.send(@attribute) == @association, "#{@attribute} was not set properly"

      check @object.send("#{@attribute}_id") == @association.id, "#{@attribute}_id was not set properly"
    end

    def failure_message_for_should
      %(expected #{@object.class} to belong to #{@attributes}, but #{@error_messages.join(', ')}")
    end

    def failure_message_for_should_not
      %(expected #{@object.class} not to belong to #{@attributes}, but #{@error_messages.join(', ')}")
    end
  end
  
  def belong_to expected, options = {}
    BelongTo.new expected, options
  end
end