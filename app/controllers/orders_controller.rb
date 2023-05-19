class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]

  def index
    @orders = Order.order(created_at: :desc)
  end

  def show; end

  def new
    @order = Order.new
    @order.items.build
  end

  def edit; end

  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: 'Order was successfully created.' }
        format.js
      else
        format.js
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: 'Order was successfully updated.' }
        format.js
      else
        format.js
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.js
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:name, items_attributes: %i[id name quantity _destroy])
  end
end
