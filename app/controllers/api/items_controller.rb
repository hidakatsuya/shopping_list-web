# frozen_string_literal: true

module Api
  class ItemsController < BaseController
    validates :create do
      string :name, required: true, strong: true
    end

    def create
      item = @current_user.items.build(name: permitted_params[:name])

      if item.save
        respond_object item.as_json(root: true, only: [ :id, :name ]), :created
      else
        respond_error :unprocessable_entity, item.errors.full_messages.join("。")
      end
    end
  end
end
