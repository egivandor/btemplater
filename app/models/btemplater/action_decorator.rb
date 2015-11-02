module Btemplater
  class ActionDecorator
    attr_reader :name, :path, :title, :icon, :method, :data
    
    def initialize(name, path, title, icon, method = :get, data = {})
      @name = name
      @path = path
      @title = title
      @icon = icon
      @method = method
      @data = data
    end
  end
end
