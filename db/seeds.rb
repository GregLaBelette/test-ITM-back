# frozen_string-literal:true
require('CSV')

puts '-' * 72
puts 'Destroying older entries'
puts '-' * 72

Order.delete_all

puts 'Entries destroyed'

puts '-' * 72
puts 'Creating Orders from CSV'
puts '-' * 72

# rubocop:disable Metrics/MethodLength
def csv_load
  orders_count = 0
  CSV.foreach(File.join(__dir__, 'data.csv'), { headers: true }) do |row|
    new_order = Order.new(build_hash(row))
    if new_order.save!
      puts "successfully saved order #{row['order_id']}"
      orders_count += 1
    else
      puts "Something went wrong saving order #{row['order_id']}"
    end
  end
  orders_count
end
# rubocop:enable Metrics/MethodLength

def build_hash(row)
  {
    date: DateTime.parse(row['date']),
    customer_id: row['customer_id'].to_i,
    country: row['country'],
    product_code: row['product_code'],
    product_description: row['product_description'],
    quantity: row['quantity'].to_i,
    unit_price: row['unit_price'].to_f
  }
end

puts '-' * 72
puts "Finished, saved #{csv_load} orders"
puts '-' * 72
