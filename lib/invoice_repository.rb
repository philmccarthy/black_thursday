require_relative 'invoice'
require_relative 'repositable'

class InvoiceRepository
  include Repositable

  attr_reader :all

  def initialize(data)
    @all = data.map { |invoice_data| Invoice.new(invoice_data) }
  end
end
