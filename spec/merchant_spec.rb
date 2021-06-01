require './lib/merchant'

RSpec.describe Merchant do
  describe 'instance methods' do
    it 'initializes from row data' do
      row_data = {
        id: '12334105',
        name: 'Shopin1901',
        created_at: '2010-12-10',
        updated_at: '2011-12-04'
      }

      merchant = Merchant.new(row_data)

      expect(merchant).to be_an_instance_of Merchant
      expect(merchant.id).to eq(row_data[:id])
      expect(merchant.name).to eq(row_data[:name])
    end
  end
end
