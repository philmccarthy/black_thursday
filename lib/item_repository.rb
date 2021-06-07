require_relative 'item'
require_relative 'repositable'

class ItemRepository
  include Repositable

  attr_reader :all, :engine

  def initialize(data, engine=nil)
    @all = data.map { |item_data| Item.new(item_data, repo=self) }
    @engine = engine
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

  def create(attributes)
    attributes[:id] = all.last.id + 1
    @all << Item.new(attributes, self)
  end

  def update(id, attributes)
    item = find_by_id(id)
    return nil if item.nil?
    item.name = attributes[:name] if attributes[:name]
    item.description = attributes[:description]  if attributes[:description]
    item.unit_price = attributes[:unit_price] if attributes[:unit_price]
    item.updated_at = Time.now.utc
  end
end
