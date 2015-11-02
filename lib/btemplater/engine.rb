require 'kaminari'
require 'simple_form'
require 'pundit'
require 'show_for'

module Btemplater
  class Engine < ::Rails::Engine
    isolate_namespace Btemplater
  end
end
