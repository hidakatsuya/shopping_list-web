class ItemsController < ApplicationController
  before_action :set_item, only: %i(edit update destroy complete incomplete)

  def index
    @items = Item.ordered.incompletes
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      respond_to do |format|
        format.html { redirect_to items_path }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      respond_to do |format|
        format.html { redirect_to items_path }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_path }
      format.turbo_stream
    end
  end

  def complete
    update_completion :complete
  end

  def incomplete
    update_completion :incomplete
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :completed)
  end

  def update_completion(completion)
    if @item.send(completion)
      respond_to do |format|
        format.html { redirect_to items_path }
        format.turbo_stream { render 'update' }
      end
    else
      render :index, status: :unprocessable_entity
    end
  end
end
