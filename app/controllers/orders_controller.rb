# frozen_string_literal:true

# Orders controller
class OrdersController < ApplicationController
  def index
    @orders = filter_orders
    @revenue = calculate_revenue
    @avg_per_order = calculate_avg
    @customers = customers_count

    respond_to do |format|
      format.html
      format.json { render json: build_json }
    end
  end

  private

  def filter_orders
    Order.all
  end

  def calculate_revenue; end

  def calculate_avg; end

  def customers_count; end

  def build_json
    {
      revenue: @revenue,
      average_per_order: calculate_avg,
      customers: customers_count
    }
  end
end
