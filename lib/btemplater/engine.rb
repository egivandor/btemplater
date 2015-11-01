require 'kaminari'
require 'simple_form'
require 'pundit'

module Btemplater
  class Engine < ::Rails::Engine
    isolate_namespace Btemplater
  end
end
