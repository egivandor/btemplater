module Btemplater
  module ApplicationHelper
    def do_title(title)
      content_tag(:div, class: 'page-header') do
        content_tag(:h1, title)
      end
    end
  end
end
