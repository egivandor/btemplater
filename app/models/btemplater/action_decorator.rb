module Btemplater
  class ActionDecorator
    attr_reader :name, :path, :title, :icon
    
    def initialize(name, path, title, icon)
      @name = name
      @path = path
      @title = title
      @icon = icon
    end
  end
end
