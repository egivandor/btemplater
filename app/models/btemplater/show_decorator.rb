module Btemplater
  class ShowDecorator
    attr_reader :name, :arguments, :block

    def initialize(name, arguments, block = nil)
      @name = name
      @arguments = arguments
      @block = block
    end
  end
end
