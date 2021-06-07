require 'bigdecimal/util'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :repo
  
  def initialize(data, repo=nil)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = BigDecimal(data[:unit_price].to_d / 100)
    @created_at = data[:created_at].is_a?(Time) ? data[:created_at] : Time.new(data[:created_at])
    @updated_at = data[:updated_at].is_a?(Time) ? data[:updated_at] : Time.new(data[:updated_at])
    @merchant_id = data[:merchant_id].to_i
    @repo = repo
  end

  def name=(name)
    @name = name
  end

  def description=(description)
    @description = description
  end

  def unit_price=(unit_price)
    @unit_price = unit_price.to_d
  end

  def updated_at=(time)
    @updated_at = time
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def merchant
    return nil if repo.nil?
    repo.engine.merchants.find_by_id(merchant_id)
  end
end
