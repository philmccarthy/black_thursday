require_relative 'merchant'
require_relative 'repositable'


class MerchantRepository
  include Repositable

  attr_reader :all

  def initialize(data)
    @all = data.map { |merchant_data| Merchant.new(merchant_data) }
  end

  def find_all_by_name(name)
    all.select { |merchant| merchant.name.downcase.include? name.downcase }
  end

  def create(attributes)
    attributes[:id] = all.last.id + 1
    @all << Merchant.new(attributes, self)
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    return nil if merchant.nil?
    merchant.name = attributes[:name]
  end
end
