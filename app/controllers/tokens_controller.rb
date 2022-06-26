# frozen_string_literal: true

class TokensController < ApplicationController
  before_action :set_token

  def show
  end

  def regenerate
    @token.regenerate_value!

    if @token.save
      respond_to do |format|
        format.html { redirect_to token_path }
      end
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    return head(:unprocessable_entity) unless @token.persisted?

    @token.destroy
    respond_to do |format|
      format.html { redirect_to token_path }
    end
  end

  private

  def set_token
    @token = current_user.token || current_user.build_token
  end
end
