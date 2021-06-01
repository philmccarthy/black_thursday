require_relative 'item'

class ItemRepository
  attr_reader :all

  def initialize(data)
    @all = data.map { |item_data| Item.new(item_data) }  
  end
end
