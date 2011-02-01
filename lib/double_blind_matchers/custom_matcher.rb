module DoubleBlindMatchers
  class CustomMatcher < DoubleBlindMatcher
    def invalid object
      "#{object.class} instance was not valid"
    end
  end
  
  Dir[File.dirname(__FILE__) + '/custom_matcher/*.rb'].each {|f| require f}
end