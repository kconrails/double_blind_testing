module DoubleBlindMatchers
  class DoubleBlindMatcher
    def initialize expected, options = {}
      @options = default_options
      @options.merge!(options) if options.is_a?(Hash)
      
      # attribute name, as a symbol
      @attribute = expected
      
      # result that starts as true, and becomes false if anything fails
      @result = true
      
      # list of error messages that collected during run
      @error_messages = []
    end
    
    def matches? actual
      get_object actual
      
      match
      
      @result
    end
    
    def match
    end
    
    def default_options
      {}
    end
    
    def error_list
      return @error_list if defined?(@error_list)
      @error_list = '[' + @object.errors[@attribute].map{|e| %("#{e}")}.join(', ') + ']'
    end
    
    def get_object actual
      return @object if defined?(@object)
      @object = actual.is_a?(Class) ? actual.new : actual
    end
    
    def class_symbol
      return @class_symbol if defined?(@class_symbol)
      @class_symbol = @object.class.name.underscore.to_sym
    end
    
    def set_to value
      @object.send("#{@attribute}=", value)
    end
    
    def check expression, error_message = nil
      unless expression
        @error_messages << error_message if error_message
        @result = false
      end
    end
    
    def create_by_factory object_sym, option = :object, attributes = {}
      if defined?(Factory)
        if Factory.factories.keys.include?(object_sym)
          return Factory.create(object_sym, attributes)
        else
          check false, "You don't have a factory defined for #{object_sym}"
        end
      else
        check false, "You don't have factory_girl installed, specify #{option} => object"
      end
    end
  end
  
  Dir[File.dirname(__FILE__) + '/*/*.rb'].each {|f| require f}
end