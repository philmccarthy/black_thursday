require 'bigdecimal/util'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id
  
  def initialize(data)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = data[:unit_price].to_d
    @created_at = DateTime.parse(data[:created_at])
    @updated_at = DateTime.parse(data[:updated_at])
    @merchant_id = data[:merchant_id].to_i
  end
end