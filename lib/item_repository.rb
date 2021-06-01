require_relative 'item'
require_relative 'repositable'

class ItemRepository
  include Repositable

  attr_reader :all

  def initialize(data)
    @all = data.map { |item_data| Item.new(item_data) }  
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
