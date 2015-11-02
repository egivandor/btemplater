module Btemplater
  module NewHelper
    def do_new(args)
      args.merge(
        title: [],
        columns: [],
        items: [],
        model: nil,
        url: nil,
        method: :get
      )
      capture do
        concat do_title(args[:title])
        concat(simple_form_for(args[:item], html: { class: 'form-horizontal' }, url: args[:url], post: args[:method]) do |f|
                concat(content_tag(:div, class: 'inputs') do
                                  args[:columns].each do |column|
                                    if column.instance_of? Btemplater::NewDecorator
                                      concat column.decorator.call(f, column)
                                    else
                                      concat f.input column
                                    end
                                  end
                                end)
                    concat(content_tag(:div, class: 'actions') do
                                          concat f.submit class: 'btn btn-primary'
                                          concat link_to t('cancel'), '#', class: 'btn btn-default'
                                        end)
                end)
      end
    end
  end
end
