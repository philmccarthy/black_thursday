require 'csv'
require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  before(:each) do
    @merchants_data = CSV.read('./spec/fixtures/merchants_fixture.csv', headers: true, header_converters: :symbol)
    @mr = MerchantRepository.new(@merchants_data)
  end

  describe 'instance methods' do
    it 'initializes with all merchants loaded as objects' do
      expect(@mr).to be_an_instance_of MerchantRepository
      expect(@mr.all).to be_an Array
      expect(@mr.all.first).to be_an_instance_of Merchant
      expect(@mr.all.last).to be_an_instance_of Merchant
      expect(@mr.all.size).to eq(9)
    end

    context '#find_by_id' do
      it 'finds an existing merchant by id' do
        merchant = @mr.find_by_id(12334115)

        expect(merchant).to be_an_instance_of Merchant
        expect(merchant.id).to eq(@merchants_data[3][:id].to_i)
        expect(merchant.name).to eq(@merchants_data[3][:name])
      end

      it 'returns nil if no matching merchant exists' do
        nil_merchant = @mr.find_by_id(777)
  
        expect(nil_merchant).to be_nil
      end
    end

    context '#find_by_name' do
      it 'returns a single merchant with matching name' do
        merchant = @mr.find_by_name('LolaMarleys')

        expect(merchant).to be_a Merchant
        expect(merchant.name).to eq('LolaMarleys')
      end
      
      it 'matches merchant name case insensitively' do
        merchant = @mr.find_by_name('LOLamarleYS')
  
        expect(merchant).to be_a Merchant
        expect(merchant.name).to eq('LolaMarleys')
      end

      it 'returns nil if no matching merchant exists' do
        nil_merchant = @mr.find_by_name('zzz')
  
        expect(nil_merchant).to be_nil
      end
    end

    context '#find_all_by_name' do
      it 'returns an array of merchants with name match fragments' do
        merchants = @mr.find_all_by_name('in')
  
        expect(merchants).to be_an Array
        expect(merchants.size).to eq(2)
        expect(merchants.first).to be_a Merchant
        expect(merchants.first.name).to include('in')
        expect(merchants.last.name).to include('in')
      end
      
      it 'returns matches case insensitively' do
        merchants = @mr.find_all_by_name('IN')
  
        expect(merchants).to be_an Array
        expect(merchants.size).to eq(2)
      end

      it 'return an empty array when no matches exist' do
        no_merchants_match = @mr.find_all_by_name('zzz')

        expect(no_merchants_match).to eq([])
      end
    end

    context '#create' do
      it 'creates a new merchant and adds it to the repository' do
        attributes = { name: 'New Merchant' }
        last_id = @mr.all.last.id

        @mr.create(attributes)

        expect(@mr.all.last).to be_a Merchant
        expect(@mr.all.last.name).to eq(attributes[:name])
        expect(@mr.all.last.id).to eq(last_id + 1)
      end
    end
  end
end
