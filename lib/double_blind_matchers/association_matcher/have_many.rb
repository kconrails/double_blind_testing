module DoubleBlindMatchers
  class HaveMany < AssociationMatcher
    def match
      @attributes = @attribute
      @attribute = @options[:singular] || @attributes.to_s.singularize.to_sym
      
      @association = @options[:association] || create_by_factory(@attribute, :association)
      @object = @options[:object] || create_by_factory(class_symbol)
      
      check @object.valid?, invalid(@object)
      check @association.valid?, invalid(@association)
      
      check !Array(@object.send(@attributes)).include?(@association), "#{@attributes} array prematurely includes #{@association.class} association"
      
      @object.send(@attributes) << @association
      check Array(@object.send(@attributes)).include?(@association), "#{@attributes} array doesn't include #{@association.class} association"
    end

    def failure_message_for_should
      %(expected #{@object.class} to have many #{@attributes}, but #{@error_messages.join(', ')}")
    end

    def failure_message_for_should_not
      %(expected #{@object.class} not to have many #{@attributes}, but #{@error_messages.join(', ')}")
    end
  end
  
  def have_many expected, options = {}
    HaveMany.new expected, options
  end
end