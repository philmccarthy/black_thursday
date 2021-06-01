require 'spec_helper'
require './lib/sales_engine'

RSpec.describe SalesEngine do
  describe 'class methods' do
    context '::from_csv' do
      it 'initializes a SalesEngine object from CSV data' do
        files = {merchants: './data/merchants.csv'}

        se = SalesEngine.from_csv(files)

        expect(se.merchants).to be_an_instance_of MerchantRepository
        expect(se.merchants.all).to be_an Array
        expect(se.merchants.all.first).to be_an_instance_of Merchant
      end
    end
  end
end