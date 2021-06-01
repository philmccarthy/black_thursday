require_relative 'merchant'

class MerchantRepository
  attr_reader :all

  def initialize(data)
    @all = data.map { |merchant_data| Merchant.new(merchant_data) }
  end
end
