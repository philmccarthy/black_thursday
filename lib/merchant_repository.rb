require_relative 'merchant'
require_relative 'repositable'


class MerchantRepository
  include Repositable

  attr_reader :all

  def initialize(data)
    @all = data.map { |merchant_data| Merchant.new(merchant_data) }
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
