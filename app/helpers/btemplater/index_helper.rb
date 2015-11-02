module Btemplater
  module IndexHelper
    def do_index(args)
      args.merge(
        title: [],
        collumns: [],
        items: [],
        model: nil,
        actions: []
      )
      concat do_title(args[:title])
      concat(paginate args[:items])
      concat(custom_table_for(args) do
              args[:columns].each do |c|
                if c.instance_of? Btemplater::IndexDecorator
                  column(c.name, args[:model].human_attribute_name(c.name), &c.decorator)
                else
                  column c, args[:model].human_attribute_name(c)
                end
              end
            end)
      (paginate args[:items])
    end

    def show_action(args)
      link_to '#', class: 'btn btn-default btn-sm', title: 'actions.show' do
        content_tag(:span, '', class: 'fa fa-file')
      end.html_safe
    end

    def action_decorator(ad, item)
      link_to ad.path.call(item), class: 'btn btn-default btn-sm', title: ad.title do
        content_tag(:span, '', class: "fa fa-#{ad.icon}")
      end.html_safe
    end

    def custom_table_for(args)
      @columns = []
      yield

      content_tag :table, class: 'table table-responsive table-hover table-striped' do
        thead(args) + tbody(args)
      end
    end

    def thead(args)
      content_tag :thead do
        content_tag :tr do 
          @columns.each do |c|
            concat(content_tag(:th, c[:value]))
          end
          concat(content_tag(:th, '')) unless args[:actions].empty?
        end
      end
    end

    def tbody(args)
      items = args[:items]
      content_tag :tbody do
        items.each do |item|
          concat(
            content_tag(:tr) do
              @columns.each do |column|
                if column[:block]
                  concat(content_tag(:td, column[:block].call(item.send(column[:name]))))
                else
                  concat(content_tag(:td, item[column[:name]]))
                end
              end
              args[:actions].each do |action|
                if action.instance_of? Btemplater::ActionDecorator
                  concat(content_tag(:td, action_decorator(action, item)))
                else
                  concat(content_tag(:td, send("#{action}_action", args)))
                end
              end
            end
          )
        end
      end
    end

    def column(name, value = nil, &block)
      value = name unless value
      @columns << { name: name, value: value, block: block }
    end

    def do_new_button(args)
      content_tag :div do
        link_to t('helpers.submit.create', model: args[:model].model_name.human), url_for(controller: args[:model].to_s.tableize, action: :new), class: 'btn btn-primary'
      end
    end
  end
end
