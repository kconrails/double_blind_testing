module DoubleBlindMatchers
  class AssociationMatcher < DoubleBlindMatcher
    def invalid object
      "#{object.class} instance was not valid"
    end
  end
  
  Dir[File.dirname(__FILE__) + '/association_matcher/*.rb'].each {|f| require f}
end