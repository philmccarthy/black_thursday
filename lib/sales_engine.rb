require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'sales_analyst'

class SalesEngine
 
  def self.from_csv(files)
    new({
      items: CSV.read(files[:items], headers: true, header_converters: :symbol),
      merchants: CSV.read(files[:merchants], headers: true, header_converters: :symbol),
      invoices: CSV.read(files[:invoices], headers: true, header_converters: :symbol)
    })
  end

  attr_reader :merchants, :items, :invoices, :analyst

  def initialize(data)
    @items = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
    @invoices = InvoiceRepository.new(data[:invoices])
    @analyst = SalesAnalyst.new(self)
  end
end
