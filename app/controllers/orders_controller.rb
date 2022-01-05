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

  def chart
    @orders = filter_orders

    respond_to do |format|
      format.html
      format.text { render partial: 'orders/chart.html.erb', locals: { orders: @orders } }
    end
  end

  private

  def filter_orders
    if params[:country].present?
      Order.where(country: params[:country])
    else
      Order.all
    end
  end

  def calculate_revenue
    @orders.sum('quantity * unit_price')
  end

  def calculate_avg
    @orders.average('quantity * unit_price')
  end

  def customers_count
    @orders.group(:customer_id).count.length
  end

  def build_json
    {
      count: @orders.count,
      revenue: @revenue,
      average_per_order: calculate_avg,
      customers: customers_count
    }
  end
end
