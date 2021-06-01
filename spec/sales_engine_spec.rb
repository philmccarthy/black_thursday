require 'spec_helper'
require './lib/sales_engine'

RSpec.describe SalesEngine do
  describe 'class methods' do
    context '::from_csv' do
      it 'initializes a SalesEngine object from CSV data' do
        files = {
          merchants: './data/merchants.csv',
          items: './data/items.csv'
        }

        se = SalesEngine.from_csv(files)

        expect(se).to be_an_instance_of SalesEngine

        expect(se.merchants).to be_an_instance_of MerchantRepository
        expect(se.merchants.all).to be_an Array
        expect(se.merchants.all.first).to be_an_instance_of Merchant

        expect(se.items).to be_an_instance_of ItemRepository
        expect(se.items.all).to be_an Array
        expect(se.items.all.first).to be_an_instance_of Item
      end
    end
  end
end
