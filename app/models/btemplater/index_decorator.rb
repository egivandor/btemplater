module Btemplater
  class IndexDecorator
    attr_reader :name, :decorator
    
    def initialize(name, decorator)
      @name = name
      @decorator = decorator
    end
  end
end
