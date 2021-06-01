require 'csv'
require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  describe 'class methods' do
    it 'initializes with all merchants loaded as objects' do
      merchants_data = CSV.read('./spec/fixtures/merchants_fixture.csv', headers: true, header_converters: :symbol)

      mr = MerchantRepository.new(merchants_data)

      expect(mr).to be_an_instance_of MerchantRepository
      expect(mr.all).to be_an Array
      expect(mr.all.first).to be_an_instance_of Merchant
      expect(mr.all.last).to be_an_instance_of Merchant
      expect(mr.all.size).to eq(9)
    end
  end
end
