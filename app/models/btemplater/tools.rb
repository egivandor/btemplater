module Btemplater
  module Tools
    def do_create(params, model, redirect_root = nil)
      @obj = model.new(obj_params(@obj, model))
      try(:before_save_create, @obj)
      # before_save_create if method_defined? :before_save_create
      if @obj.save
        if redirect_root.nil?
          redirect_to @obj
        else
          redirect_to redirect_root
        end
      else
        render "new"
      end
    end

    private

    def obj_params(obj, model)
      policy = "#{model}Policy".constantize.new(current_user, obj || model)
      params.require(model.to_s.demodulize.underscore.to_sym).permit(policy.permitted_attributes)
    end
  end
end
