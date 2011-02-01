module DoubleBlindMatchers
  class ValidationMatcher < DoubleBlindMatcher
    def failure_message_for_should
      %(expected errors #{error_list} to include "#{@options[:message]}", but #{@error_messages.join(', ')})
    end
    
    def failure_message_for_should_not
      %(did not expect errors #{error_list} to include "#{@options[:message]}", but #{@error_messages.join(', ')})
    end
    
    def shouldnt_exist
      "error existed when it shouldn't"
    end
    
    def valid_when this_happens
      "should not be valid when #{this_happens}"
    end
  end
  
  Dir[File.dirname(__FILE__) + '/validation_matcher/*.rb'].each {|f| require f}
end