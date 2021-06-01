require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine
 
  def self.from_csv(files)
    items_data = CSV.read('./data/items.csv', headers: true, header_converters: :symbol)
    merchants_data = CSV.read(files[:merchants], headers: true, header_converters: :symbol)
    new({
      items: items_data,
      merchants: merchants_data
      }
    )
  end

  attr_reader :merchants, :items

  def initialize(data)
    @items = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
  end
end
