require_relative 'item'
require_relative 'repositable'

class ItemRepository
  include Repositable

  attr_reader :all

  def initialize(data)
    @all = data.map { |item_data| Item.new(item_data) }  
  end

  def find_all_with_description(description)
    all.select { |item| item.description.downcase.include? description.downcase }
  end

  def find_all_by_price(price)
    all.select { |item| item.unit_price == price }
  end

  def find_all_by_price_in_range(range)
    all.select { |item| item.unit_price.between? range.first, range.last }
  end

  def find_all_by_merchant_id(merchant_id)
    all.select { |item| item.merchant_id == merchant_id }
  end
end
