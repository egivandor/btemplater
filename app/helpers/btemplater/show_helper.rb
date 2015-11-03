module Btemplater
  module ShowHelper
    def do_show(args)
      raise Pundit::NotAuthorizedError unless "#{args[:model]}Policy".constantize.new(current_user, args[:item]).show?

      args.merge(
        title: [],
        columns: [],
        item: nil,
        model: nil,
        url: nil
      )
      capture do
        concat do_title(args[:title])
        concat(
          show_for(args[:item]) do |s|
            args[:columns].each do |column|
              if column.instance_of? Btemplater::ShowDecorator
                if column.block.nil?
                  concat(s.attribute column.name, column.arguments)
                else
                  concat(s.attribute(column.name, column.arguments) do
                    column.block.call(s.object.send(column.name))
                  end)
                end
              else
                # concat(s.label column)
                concat(s.attribute column)
              end
            end
          end
        )
        concat(
          content_tag(:div, class: 'actions') do
            link_to t('actions.back', scope: :btemplater), args[:url] || :back, class: 'btn btn-primary'
          end
        )
      end
    end
  end
end
