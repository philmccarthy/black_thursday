require_relative 'invoice'
require_relative 'repositable'

class InvoiceRepository
  include Repositable

  attr_reader :all, :engine

  def initialize(data, engine=nil)
    @all = data.map { |invoice_data| Invoice.new(invoice_data, self) }
    @engine = engine
  end
end
