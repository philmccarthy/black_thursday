require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine
 
  def self.from_csv(files)
    new({
      items: CSV.read(files[:items], headers: true, header_converters: :symbol),
      merchants: CSV.read(files[:merchants], headers: true, header_converters: :symbol)
    })
  end

  attr_reader :merchants, :items

  def initialize(data)
    @items = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
  end
end
