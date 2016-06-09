# Handle requests relating to making an order
class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]

  def index
    render json: Order.all
  end

  def show
    render json: @order
  end

  def create
    order = Order.new(order_params)
    if order.save
      render json: order, status: :created, location: order
    else
      # https://github.com/rails-api/active_model_serializers/blob/master/docs/jsonapi/errors.md
      render json: order,
             status: :unprocessable_entity,
             adapter: :json_api,
             serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:data)
            .require(:attributes)
            .permit(:account, :direction, :order_type, :price, :quantity, :symbol, :venue)
    end
end
