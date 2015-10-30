module Btemplater
  module IndexHelper
    def do_render(args)
      args.merge(
        title: [],
        collumns: [],
        items: []
      )
      # concat do_title(title)
      custom_table_for(args[:items]) do
        args[:columns].each do |column|
          column column, 'ID'
          # column :subject, 'Subject'
        end
      end
    end

    def do_title(title)
      content_tag(:h1, title)
    end

    def custom_table_for(items)
      @columns = []
      yield

      content_tag :table, class: 'table table-responsive table-hover table-striped' do
        thead + tbody(items)
      end
    end

    def thead
      content_tag :thead do
        content_tag :tr do 
          @columns.each do |c|
            concat(content_tag(:th, c[:value]))
          end
        end
      end
    end

    def tbody(items)
      content_tag :tbody do
        items.each do |e|
          concat(
            content_tag(:tr) do
              @columns.each do |c|
                e[c[:name]] = c[:block].call(e[c[:name]]) if c[:block]
                concat(content_tag(:td, e[c[:name]]))
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
  end
end
