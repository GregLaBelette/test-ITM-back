# frozen_string_literal:true

# Orders controller
class OrdersController < ApplicationController
  def index
    @countries = countries
    @orders = filter_orders
    @revenue = calculate_revenue
    @avg_per_order = calculate_avg
    @customers = customers_count

    respond_to do |format|
      format.html
      format.json { render json: summary_data }
    end
  end

  def chart
    @orders = filter_orders

    respond_to do |format|
      format.html
      format.json { render json: chart_data }
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

  def countries
    Order.group(:country).count.keys
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

  def summary_data
    {
      countries: @countries,
      count: @orders.count,
      revenue: @revenue,
      average_per_order: calculate_avg,
      customers: customers_count
    }
  end

  def chart_data
    @orders.group("DATE_TRUNC('month', date)").sum('quantity * unit_price').transform_keys { |k| k.strftime('%b %Y') }
  end
end
