require_relative 'merchant'

class MerchantRepository

  attr_reader :merchants

  def initialize(data)
    @merchants = data.map { |merchant_data| Merchant.new(merchant_data) }
  end
end
